import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_43/models/chat.dart';
import 'package:practice_flutter_application_43/models/message.dart';
import 'package:practice_flutter_application_43/models/user_profile.dart';
import 'package:practice_flutter_application_43/services/auth_service.dart';
import 'package:practice_flutter_application_43/services/database_service.dart';
import 'package:practice_flutter_application_43/services/media_service.dart';
import 'package:practice_flutter_application_43/services/navigation_service.dart';
import 'package:practice_flutter_application_43/services/storage_service.dart';
import 'package:practice_flutter_application_43/utils.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  const ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageService _storageService;

  ChatUser? currentUser, otherUser;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _databaseService = _getIt.get<DatabaseService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();

    currentUser = ChatUser(
      id: _authService.user!.uid,
      firstName: _authService.user!.displayName,
    );

    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name,
      profileImage: widget.chatUser.pfpURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.name!),
        leadingWidth: 108,
        leading: Row(
          children: [
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                _navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.chatUser.pfpURL!),
            ),
          ],
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          messages = _generateChatMessageList(chat.messages!);
        }
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
            borderRadius: 10,
            currentUserContainerColor: Colors.green,
          ),
          inputOptions: InputOptions(
            alwaysShowSend: true,
            trailing: [_messageMediaButton()],
          ),
          currentUser: currentUser!,
          onSend: _sendMessage,
          messages: messages,
        );
      },
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias!.first.type == MediaType.image) {
        Message message = Message(
          senderID: currentUser!.id,
          content: chatMessage.medias!.first.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        await _databaseService.sendChatMessage(
          currentUser!.id,
          otherUser!.id,
          message,
        );
      }
    } else {
      Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text.trim(),
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

  ///////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////

  List<ChatMessage> _generateChatMessageList(List<Message> message) {
    List<ChatMessage> chatMessage = message.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
          user: m.senderID != currentUser!.id ? otherUser! : currentUser!,
          medias: [
            ChatMedia(url: m.content!, fileName: "", type: MediaType.image),
          ],
          createdAt: m.sentAt!.toDate(),
        );
      } else {
        return ChatMessage(
          user: m.senderID != currentUser!.id ? otherUser! : currentUser!,
          text: m.content!,
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();

    chatMessage.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return chatMessage;
  }

  ///////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////

  Widget _messageMediaButton() {
    return IconButton(
      onPressed: () async {
        File? image = await _mediaService.selectImageFromGallery();

        if (image != null) {
          String chatID = generateChatID(
            uid1: currentUser!.id,
            uid2: otherUser!.id,
          );
          String? chatImageURL = await _storageService.uploadImageToChat(
            image,
            chatID,
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
