import 'package:flutter/material.dart';
import 'package:practice_flutter_application_67/data.dart';
import 'package:practice_flutter_application_67/inherit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyInherite(
      database: MyData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var database = MyInherite.of(context)!.database;

    return Scaffold(
      body: Center(
        child: Column(
          children: [Text(database.name()), Text(database.phone())],
        ),
      ),
    );
  }
}
