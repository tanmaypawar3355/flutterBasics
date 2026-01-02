import 'package:flutter/material.dart';
import 'package:practice_flutter_application_32/pages/home_page.dart';
import 'package:practice_flutter_application_32/pages/login_page.dart';
import 'package:practice_flutter_application_32/pages/register_page.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _naviagtionKey = GlobalKey();
  NavigationService() {
    _naviagtionKey = GlobalKey<NavigatorState>();
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LogInPage(),
    "/home": (context) => HomePage(),
    "/register": (context) => RegisterPage(),
  };

  GlobalKey<NavigatorState> get navigationKey {
    return _naviagtionKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  void pushNamed(String routeName) {
    _naviagtionKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    print("lalala");
    _naviagtionKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _naviagtionKey.currentState?.pop();
  }
}
