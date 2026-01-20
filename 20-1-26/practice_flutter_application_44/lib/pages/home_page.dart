import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_44/models/user_profile.dart';
import 'package:practice_flutter_application_44/pages/chat_page.dart';
import 'package:practice_flutter_application_44/services/alert_service.dart';
import 'package:practice_flutter_application_44/services/auth_service.dart';
import 'package:practice_flutter_application_44/services/database_service.dart';
import 'package:practice_flutter_application_44/services/navigation_service.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  _authService.logout();
                  _navigationService.pushReplacementNamed("/login");
                  _alertService.showToast(
                    title: "Logout successful!",
                    icon: Icons.check,
                  );
                },
                icon: Icon(Icons.logout, color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 15),
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
      stream: _databaseService.getUserProfileCollection(),
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  splashColor: Colors.pink,
                  // shape: ShapeBorder.,

                  title: Text(
                    user.name!,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 110, 110, 110),
                          offset: Offset(0, 5),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(user.pfpURL!),
                    ),
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
