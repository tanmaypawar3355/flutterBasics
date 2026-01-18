import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pracctice_flutter_application_41/models/chat.dart';
import 'package:pracctice_flutter_application_41/models/message.dart';
import 'package:pracctice_flutter_application_41/models/user_profile.dart';
import 'package:pracctice_flutter_application_41/services/auth_service.dart';
import 'package:pracctice_flutter_application_41/services/database_service.dart';
import 'package:pracctice_flutter_application_41/services/media_service.dart';
import 'package:pracctice_flutter_application_41/services/storage_service.dart';
import 'package:pracctice_flutter_application_41/utils.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  const ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser? currentUser, otherUser;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageService _storageService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _databaseService = _getIt.get<DatabaseService>();
    _storageService = _getIt.get<StorageService>();
    _mediaService = _getIt.get<MediaService>();

    currentUser = ChatUser(
      id: _authService.user!.uid,
      firstName: _authService.user!.displayName,
    );

    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name!,
      profileImage: widget.chatUser.pfpURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatUser.name!)),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: _chats(),
      ),
    );
  }

  Widget _chats() {
    return StreamBuilder(
      stream: _databaseService.getChatData(currentUser!.id, otherUser!.id),
      builder: (context, snapshot) {
        Chat? chat = snapshot.data?.data();
        List<ChatMessage> messages = [];

        if (chat != null && chat.messages != null) {
          messages = _generateChatMessage(chat.messages!);
        }
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: InputOptions(
            alwaysShowSend: true,
            trailing: [_imageButton()],
          ),
          currentUser: currentUser!,
          onSend: _sendMessage,
          messages: messages,
        );
      },
    );
  }

  //////////////////////////////////////////////////////
  //////////////////////////////////////////////////////

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      final media = chatMessage.medias!.first; 
        Message message = Message(
          senderID: currentUser!.id,
          content: media.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );

        _databaseService.sendChatMessage(
          currentUser!.id,
          otherUser!.id,
          message,
        );
      } else {
        Message message = Message(
          senderID: currentUser!.id,
          content: chatMessage.text,
          messageType: MessageType.Text,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        await _databaseService.sendChatMessage(
          currentUser!.id,
          otherUser!.id,
          message,
        );
      }
    }
  

  /////////////////////////////////////////////////////
  //////////////////////////////////////////////////////

  List<ChatMessage> _generateChatMessage(List<Message> message) {
    List<ChatMessage> chatMessage = message.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          medias: [
            ChatMedia(url: m.content!, fileName: "", type: MediaType.image),
          ],
          createdAt: m.sentAt!.toDate(),
        );
      } else {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          text: m.content!,
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();

    chatMessage.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return chatMessage;
  }

  /////////////////////////////////////////////////////
  //////////////////////////////////////////////////////

  Widget _imageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.selectImageFormGallery();

        if (file != null) {
          String chatID = generateChatID(
            uid1: currentUser!.id,
            uid2: otherUser!.id,
          );

          String? chatImageURL = await _storageService.uploadImageToChat(
            file: file,
            chatID: chatID,
          );

          if (chatImageURL != null) {
            ChatMessage chatMessage = ChatMessage(
              user: currentUser!,
              medias: [
                ChatMedia(
                  url: chatImageURL,
                  fileName: "",
                  type: MediaType.image,
                ),
              ],
              createdAt: DateTime.now(),
            );

            _sendMessage(chatMessage);
          }
        }
      },
      icon: Icon(Icons.image),
    );
  }
}
