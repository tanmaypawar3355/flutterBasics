// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Tanmay", style: TextStyle(fontSize: 30)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, color: Colors.orange),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Button 1")),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, color: Colors.orange),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Button 1")),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, color: Colors.orange),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Button 1")),
            ],
          ),
        ],
      ),
    );
  }
}
