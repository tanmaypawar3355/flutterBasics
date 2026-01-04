import 'package:flutter/material.dart';
import 'package:practice_flutter_application_34/pages/home_page.dart';
import 'package:practice_flutter_application_34/pages/login_page.dart';
import 'package:practice_flutter_application_34/pages/registration_page.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  NavigationService() {
    _navigationKey = GlobalKey<NavigatorState>();
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/home": (context) => HomePage(),
    "/register": (context) => RegistrationPage(),
  };

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  GlobalKey<NavigatorState> get navigationKey {
    return _navigationKey;
  }

  void pushNamed(String routeName) {
    _navigationKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigationKey.currentState?.pushReplacementNamed(routeName);
  }
}
