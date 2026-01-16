import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_40/models/chat.dart';
import 'package:practice_flutter_application_40/models/message.dart';
import 'package:practice_flutter_application_40/models/user_profile.dart';
import 'package:practice_flutter_application_40/services/auth_service.dart';
import 'package:practice_flutter_application_40/services/database_service.dart';
import 'package:practice_flutter_application_40/services/media_service.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser? currentUser, otherUser;

  final GetIt _getIt = GetIt.instance;

  late DatabaseService _databaseService;
  late AuthService _authService;
  late MediaService _mediaService;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _authService = _getIt.get<AuthService>();
    _mediaService = _getIt.get<MediaService>();

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
    return Scaffold(body: _buildUI());
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
          messages = _generateChatMessageList(chat.messages!);
        }
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: InputOptions(
            alwaysShowSend: true,
            trailing: [
              SizedBox(width: 10),
              _messageMediaButton,
              SizedBox(width: 10),
            ],
          ),
          currentUser: currentUser!,
          messages: messages,
          onSend: _sendMessage,
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    Message message = Message(
      senderID: currentUser!.id,
      content: chatMessage.text,
      messageType: MessageType.Text,
      sentAt: Timestamp.fromDate(chatMessage.createdAt),
    );
    _databaseService.sendChatMessage(currentUser!.id, otherUser!.id, message);
  }

  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

  List<ChatMessage> _generateChatMessageList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages
        .map(
          (m) => ChatMessage(
            user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
            text: m.content!,
            createdAt: m.sentAt!.toDate(),
          ),
        )
        .toList();

    return chatMessages;
  }

  //////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

  Widget _messageMediaButton()  {

    return IconButton(
      onPressed: () {
        
      },
      icon: Icon(Icons.image),
    );
    File? file = await _mediaService.getImageFromGallery();
  }
}
