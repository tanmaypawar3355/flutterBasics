import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_flutter_application_35/pages/home_page.dart';
import 'package:practice_flutter_application_35/pages/login_page.dart';
import 'package:practice_flutter_application_35/pages/register_page.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  NavigationService() {
    _navigationKey = GlobalKey<NavigatorState>();
  }

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
