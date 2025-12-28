import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_28/pages/loginPage.dart';
import 'package:practice_flutter_application_28/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(const MyApp());
}

Future<void> setUp() async {
  print("In setup");
  await setUpFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),

      home: LoginPage(),
    );
  }
}
