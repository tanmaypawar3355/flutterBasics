import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_32/services/alert_service.dart';
import 'package:practice_flutter_application_32/services/navigation_service.dart';

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
            icon: Icon(Icons.logout),
            onPressed: () {
              _navigationService.pushReplacementNamed("/login");
              _alertService.showToast(
                title: "Succesfully logged out!",
                icon: Icons.check,
              );
            },
            color: Colors.red,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
    );
  }
}
