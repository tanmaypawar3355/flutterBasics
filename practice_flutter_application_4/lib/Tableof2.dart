import 'package:flutter/material.dart';

class TableOf2 extends StatefulWidget {
  const TableOf2({super.key});

  @override
  State<TableOf2> createState() => _Tableof2State();
}

class _Tableof2State extends State<TableOf2> {
  int _count = 2;

  void _printValues() {
    setState(() {
      if (_count < 12) {
        _count = _count + 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table of 2", style: TextStyle(fontSize: 30)),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Click the button to print the table values.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text("$_count"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _printValues();
              },
              child: Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
