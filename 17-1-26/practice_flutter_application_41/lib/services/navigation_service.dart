import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pracctice_flutter_application_41/pages/home_page.dart';
import 'package:pracctice_flutter_application_41/pages/login_page.dart';
import 'package:pracctice_flutter_application_41/pages/register_page.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey();
  NavigationService();

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/home": (context) => HomePage(),
    "/register": (context) => RegisterPage(),
  };

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  GlobalKey<NavigatorState> get navigationKey {
    return _navigationKey;
  }

  void push(MaterialPageRoute route) {
    _navigationKey.currentState!.push(route);
  }

  void pushNamed(String routeName) {
    _navigationKey.currentState!.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigationKey.currentState!.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigationKey.currentState!.pop();
  }
}
