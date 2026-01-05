
import 'package:flutter/material.dart';
import 'package:practice_flutter_application_33/pages/home_page.dart';
import 'package:practice_flutter_application_33/pages/login_page.dart';
import 'package:practice_flutter_application_33/pages/registration_page.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  NavigationService() {
    _navigationKey = GlobalKey();
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/home": (context) => HomePage(),
    "/register": (context) => RegistrationPage(),
  };

  GlobalKey<NavigatorState> get navgationKey {
    return _navigationKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  void pushNamed(String routeName) {
    _navigationKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigationKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigationKey.currentState?.pop();
  }
}
