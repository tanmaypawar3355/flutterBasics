import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_48/models/chat.dart';
import 'package:practice_flutter_application_48/models/message.dart';
import 'package:practice_flutter_application_48/models/user_profile.dart';
import 'package:practice_flutter_application_48/services/auth_service.dart';
import 'package:practice_flutter_application_48/services/database_service.dart';
import 'package:practice_flutter_application_48/services/media_service.dart';
import 'package:practice_flutter_application_48/services/navigation_service.dart';
import 'package:practice_flutter_application_48/services/storage_service.dart';
import 'package:practice_flutter_application_48/utils.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  const ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService;
  late MediaService _mediaService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  ChatUser? currentUser, otherUser;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();

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
        leadingWidth: 100,
        title: Text(widget.chatUser.name!),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                _navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios_new),
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
          messages = _generateChatMessagesList(chat.messages!);
        }
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
            currentUserContainerColor: Colors.green,
            borderRadius: 10,
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

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  void _sendMessage(ChatMessage chatMessage) {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias!.first.type == MediaType.image) {
        Message message = Message(
          senderID: currentUser!.id,
          content: chatMessage.medias!.first.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        _databaseService.sendChatMessage(
          currentUser!.id,
          otherUser!.id,
          message,
        );
      }
    } else {
      Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );

      _databaseService.sendChatMessage(currentUser!.id, otherUser!.id, message);
    }
  }
  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
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

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return chatMessages;
  }

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  Widget _messageMediaButton() {
    return IconButton(
      onPressed: () async {
        File? image = await _mediaService.selectImageFromGallery();

        if (image != null) {
          String chatID = generateChatId(
            uid1: currentUser!.id,
            uid2: otherUser!.id,
          );
          String? chatImageURL = await _storageService.uploadChatImage(
            file: image,
            chatID: chatID,
          );

          ChatMessage chatMessage = ChatMessage(
            user: currentUser!,
            medias: [
              ChatMedia(
                url: chatImageURL!,
                fileName: "",
                type: MediaType.image,
              ),
            ],
            createdAt: DateTime.now(),
          );
          _sendMessage(chatMessage);
        }
      },
      icon: Icon(Icons.image),
    );
  }

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////
}
