import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_40/models/chat_tile.dart';
import 'package:practice_flutter_application_40/models/user_profile.dart';
import 'package:practice_flutter_application_40/pages/chat_page.dart';
import 'package:practice_flutter_application_40/services/alert_service.dart';
import 'package:practice_flutter_application_40/services/auth_service.dart';
import 'package:practice_flutter_application_40/services/database_service.dart';
import 'package:practice_flutter_application_40/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
            onPressed: () async {
              await _authService.signout();
              _alertService.showToast(
                text: "Logout successful!",
                icon: Icons.check,
              );
              _navigationService.pushReplacementNamed("/login");
            },
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
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
      stream: _databaseService.getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Unable to load data"));
        }

        if (snapshot.data != null && snapshot.hasData) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ChatTile(
                  userProfile: user,
                  onTap: () async {
                    final chatExists = await _databaseService.checkChatExists(
                      _authService.user!.uid,
                      user.uid!,
                    );
                    print(chatExists);

                    if (!chatExists) {
                      await _databaseService.createNewChat(
                        _authService.user!.uid,
                        user.uid!,
                      );
                    }

                    _navigationService.push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChatPage(chatUser: user);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
