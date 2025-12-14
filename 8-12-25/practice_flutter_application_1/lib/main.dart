import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tanmay", style: TextStyle(fontSize: 30)),
        ),
        body: Center(child: Text("Tanmay", style: TextStyle(fontSize: 50))),
      ),
    );
  }
}
