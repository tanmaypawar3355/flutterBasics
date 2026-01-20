import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_45/models/chat.dart';
import 'package:practice_flutter_application_45/models/message.dart';
import 'package:practice_flutter_application_45/models/user_profile.dart';
import 'package:practice_flutter_application_45/services/auth_service.dart';
import 'package:practice_flutter_application_45/services/database_service.dart';
import 'package:practice_flutter_application_45/services/media_service.dart';
import 'package:practice_flutter_application_45/services/navigation_service.dart';
import 'package:practice_flutter_application_45/services/storage_service.dart';
import 'package:practice_flutter_application_45/utils.dart';

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

  ChatUser? currentUser, otherUser;
  // late AlertService _alertService;
  late MediaService _mediaService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();

    currentUser = ChatUser(
      id: _authService.user!.uid,
      firstName: _authService.user!.displayName,
    );
    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name,
      profileImage: widget.chatUser.pfpURL,
    );
    // _alertService = _getIt.get<AlertService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                _navigationService.pushNamed("/home");
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp),
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.chatUser.pfpURL!),
            ),
          ],
        ),
        title: Text(widget.chatUser.name!),
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

  List<ChatMessage> _generateChatMessageList(List<Message> messages) {
    List<ChatMessage> chatMessage = messages.map((m) {
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

  Widget _messageMediaButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.selectImageFromGallery();

        if (file != null) {
          String chatID = generateChatId(
            uid1: currentUser!.id,
            uid2: otherUser!.id,
          );

          String? imageURL = await _storageService.uploadChatImage(
            file: file,
            chatID: chatID,
          );

          ChatMessage chatMessage = ChatMessage(
            user: currentUser!,
            medias: [
              ChatMedia(url: imageURL!, fileName: "", type: MediaType.image),
            ],
            createdAt: DateTime.now(),
          );

          _sendMessage(chatMessage);
        }
      },
      icon: Icon(Icons.image),
    );
  }
}
