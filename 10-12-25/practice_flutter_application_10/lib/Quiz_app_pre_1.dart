import 'package:flutter/material.dart';

class QuizAppPre_1 extends StatefulWidget {
  const QuizAppPre_1({super.key});

  @override
  State<QuizAppPre_1> createState() => _QuizAppPre_1State();
}

class _QuizAppPre_1State extends State<QuizAppPre_1> {
  List No = ["1", "2", "3", "4", "5", "6", "7", "8"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: No.length,
          itemBuilder: (context, index) {
            return Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.all(30),
              color: Colors.blue,
              child: Center(child: Text(No[index])),
            );
          },
        ),
      ),
    );
  }
}
