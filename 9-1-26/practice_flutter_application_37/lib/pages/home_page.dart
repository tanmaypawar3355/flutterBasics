import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_37/models/chat_tile.dart';
import 'package:practice_flutter_application_37/models/user_profile.dart';
import 'package:practice_flutter_application_37/services/alert_service.dart';
import 'package:practice_flutter_application_37/services/database_service.dart';
import 'package:practice_flutter_application_37/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
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
              _navigationService.pushReplacementNamed("/login");
              _alertService.showToast(
                text: "Successfully logged out!",
                icon: Icons.check,
              );
            },
            icon: Icon(Icons.logout),
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
        child: _chatsList(),
      ),
    );
  }

  Widget _chatsList() {
    return StreamBuilder(
      stream: _databaseService.getUserProfiles(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Unable to load data."));
        }
        print(snapshot.data);
        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserProfile user = users[index].data();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ChatTile(userProfile: user, onTap: () {}),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
