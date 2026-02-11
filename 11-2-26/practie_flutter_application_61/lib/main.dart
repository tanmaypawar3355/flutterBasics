import 'package:flutter/material.dart';
import 'package:practie_flutter_application_61/screens/A_home_page_1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practie_flutter_application_61/screens/B_home_page_2.dart';
import 'package:practie_flutter_application_61/screens/C_home_page_3.dart';

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
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: HomePage3(),
    );
  }
}
