import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/models/chat_tile.dart';
import 'package:practice_flutter_application_38/models/user_profile.dart';
import 'package:practice_flutter_application_38/services/alert_servie.dart';
import 'package:practice_flutter_application_38/services/auth_service.dart';
import 'package:practice_flutter_application_38/services/database_service.dart';
import 'package:practice_flutter_application_38/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Messages"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _authService.logout();
              _navigationService.pushReplacementNamed("/login");
              _alertService.showToast(
                text: "Logout successful!",
                icon: Icons.check,
              );
            },
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: _chatList(),
      ),
    );
  }

  Widget _chatList() {
    return StreamBuilder(
      stream: _databaseService.getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Unable to load data"));
        }

        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserProfile userP = users[index].data();
              return ChatTile(userProfile: userP, onTap: () {});
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
