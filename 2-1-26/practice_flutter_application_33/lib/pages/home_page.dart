import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_33/services/alert_service.dart';
import 'package:practice_flutter_application_33/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AlertService _alertService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
            onPressed: () {
              _alertService.showToast(
                text: "Successfully logged out!",
                icon: Icons.check,
              );
              _navigationService.pushReplacementNamed("/login");
            },
            icon: Icon(Icons.logout),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
    );
  }
}
