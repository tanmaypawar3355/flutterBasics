import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_35/services/auth_service.dart';
import 'package:practice_flutter_application_35/services/navigation_service.dart';
import 'package:practice_flutter_application_35/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MainApp());
}

Future<void> setUp() async {
  await setUpFirebase();
  await registerServices();
}

class MainApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;

  MainApp({super.key}) {
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigationKey,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      // home: LoginPage(),
      routes: _navigationService.routes,
      initialRoute: _authService.user != null ? "/home" : "/login",
    );
  }
}
