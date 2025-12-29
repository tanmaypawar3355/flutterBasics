import 'package:flutter/material.dart';
import 'package:practice_flutter_application_29/pages/home_page.dart';
import 'package:practice_flutter_application_29/pages/login_page.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  NavigationService() {
    _navigationKey = GlobalKey<NavigatorState>();
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login" : (context) => LogIn(),
    "/home" : (context) => HomePage(),
  };

  GlobalKey<NavigatorState> get navigtionKey {
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

  void goBack(String routeName) {
    _navigationKey.currentState?.pop();
  }
}
