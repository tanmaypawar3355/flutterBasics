import 'package:flutter/material.dart';
import 'package:practice_flutter_application_27/pages/homePage.dart';
import 'package:practice_flutter_application_27/pages/loginPage.dart';

class NavigationService {
  // to hold the current state of out navigation state
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/home" : (context) => HomePage(),
  };

  GlobalKey<NavigatorState>? get navigatorkey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushNamed(String routName) {
    _navigatorKey.currentState?.pushNamed(routName);
  }

  void pushReplacementNamed(String routName) {
    _navigatorKey.currentState?.pushReplacementNamed(routName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
