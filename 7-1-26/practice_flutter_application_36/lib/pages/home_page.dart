import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_36/services/alert_service.dart';
import 'package:practice_flutter_application_36/services/auth_Service.dart';
import 'package:practice_flutter_application_36/services/navigation_service.dart';

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

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
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
              _alertService.showToast(
              message: "Succesfully logged out!",
              icon: Icons.check,
            );
              _authService.logout();
              _navigationService.pushReplacementNamed("/login");
            },
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
