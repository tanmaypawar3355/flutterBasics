import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_application_59/screens/A_home_page_1.dart';
import 'package:practice_flutter_application_59/screens/B_hone_page_2.dart';
import 'package:practice_flutter_application_59/screens/C_home_page_3.dart';
import 'package:practice_flutter_application_59/screens/D_home_page_4.dart';
import 'package:practice_flutter_application_59/screens/E_home_page_5.dart';
import 'package:practice_flutter_application_59/screens/F_home_page_6.dart';
import 'package:practice_flutter_application_59/screens/G_home_page_7.dart';
import 'package:practice_flutter_application_59/screens/H_home_page_8.dart';

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
      home: HomePage8()
    );
  }
}
