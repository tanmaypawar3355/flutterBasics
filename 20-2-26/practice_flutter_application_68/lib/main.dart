// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  final String title = "Title from MyApp";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyPageLevel1(title: title));
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel1 extends StatefulWidget {
  final String title;
  const MyPageLevel1({Key? key, required this.title}) : super(key: key);

  @override
  State<MyPageLevel1> createState() => _MyHomePageLevel1State();
}

class _MyHomePageLevel1State extends State<MyPageLevel1> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    return Scaffold(
      body: Center(child: MyPageLevel2(title: title)),
    );
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel2 extends StatefulWidget {
  final String title;
  const MyPageLevel2({Key? key, required this.title}) : super(key: key);

  @override
  State<MyPageLevel2> createState() => _MyPageLevel2State();
}

class _MyPageLevel2State extends State<MyPageLevel2> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    return ElevatedButton(
      onPressed: () {},
      child: MyPageLevel3(title: title),
    );
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel3 extends StatelessWidget {
  final String title;

  const MyPageLevel3({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
