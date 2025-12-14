import 'package:flutter/material.dart';
import 'package:practice_flutter_application_10/Quiz_app_pre_1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizAppPre_1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
