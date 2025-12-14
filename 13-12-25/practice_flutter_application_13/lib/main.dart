import 'package:flutter/material.dart';
import 'package:practice_flutter_application_13/pickADate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: PickADate(),
    );
  }
}
