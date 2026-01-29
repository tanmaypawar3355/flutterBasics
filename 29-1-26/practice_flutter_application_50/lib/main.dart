import 'package:flutter/material.dart';
import 'package:practice_flutter_application_50/screens/home_screen_1.dart';
import 'package:practice_flutter_application_50/screens/home_screen_2.dart';
import 'package:practice_flutter_application_50/screens/home_screen_3.dart';

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
      ),
      home: HomeScreen3(),
    );
  }
}
