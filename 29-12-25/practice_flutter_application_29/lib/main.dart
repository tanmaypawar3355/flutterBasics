import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_29/pages/login_page.dart';
import 'package:practice_flutter_application_29/services/navigation_service.dart';
import 'package:practice_flutter_application_29/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async {
  await setUpFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  late NavigationService _navigationService;
  MyApp({super.key}) {
    final GetIt _getIt = GetIt.instance;
   _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigtionKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.blue,
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: LogIn(),
      initialRoute: "/login",
      routes: _navigationService.routes,

    );
  }
}
