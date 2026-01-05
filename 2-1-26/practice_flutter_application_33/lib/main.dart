import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_33/services/auth_service.dart';
import 'package:practice_flutter_application_33/services/navigation_service.dart';
import 'package:practice_flutter_application_33/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async {
  await setUpFirebase();
  await registerServices();
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;

  MyApp({super.key}) {
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navgationKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      // home: LoginPage(),
      initialRoute: _authService.user != null ? "/login" : "/home",
      routes: _navigationService.routes,
    );
  }
}
