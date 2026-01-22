import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_47/models/user_profile.dart';
import 'package:practice_flutter_application_47/pages/chat_page.dart';
import 'package:practice_flutter_application_47/services/alert_service.dart';
import 'package:practice_flutter_application_47/services/auth_service.dart';
import 'package:practice_flutter_application_47/services/database_service.dart';
import 'package:practice_flutter_application_47/services/navigation_service.dart';

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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _authService.logout();
              _alertService.showToast(
                title: "Logout successful!",
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
          return Center(child: Text("Unable to load data!"));
        }

        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserProfile? user = users[index].data();
              return ListTile(
                title: Text(user.name!),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.pfpURL!),
                ),
                onTap: () async {
                  bool chatExists = await _databaseService.checkChatExists(
                    _authService.user!.uid,
                    user.uid!,
                  );

                  if (!chatExists) {
                    _databaseService.createNewChat(
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
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
