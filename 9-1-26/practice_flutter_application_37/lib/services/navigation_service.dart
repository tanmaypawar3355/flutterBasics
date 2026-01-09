import 'package:flutter/material.dart';
import 'package:practice_flutter_application_37/pages/home_page.dart';
import 'package:practice_flutter_application_37/pages/login_page.dart';
import 'package:practice_flutter_application_37/pages/register_page.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/register": (context) => RegisterPage(),
    "/home": (context) => HomePage(),
  };

  GlobalKey<NavigatorState> get navigationKey {
    return _navigationKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
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
