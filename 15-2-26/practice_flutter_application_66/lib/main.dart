import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_66/screens/A_home_page_1.dart';
import 'package:practice_flutter_application_66/screens/B_home_page_2.dart';
import 'package:practice_flutter_application_66/screens/D_home_page_4.dart';
import 'package:practice_flutter_application_66/screens/E_home_page_5.dart';
import 'package:practice_flutter_application_66/screens/F_home_page_6.dart';
import 'package:practice_flutter_application_66/screens/G_home_screen_7.dart';
import 'package:practice_flutter_application_66/screens/c_home_page_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      home: HomePage7()
    );
  }
}
