import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Model extends InheritedWidget {
  final String title;

  Model({
    this.title = "Hello from InheritedWidget",
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Model? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Model>();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Model(key: null, child: MaterialApp(home: MyPageLevel1()));
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel1 extends StatefulWidget {
  const MyPageLevel1({super.key});

  @override
  State<MyPageLevel1> createState() => _MyHomePageLevel1State();
}

class _MyHomePageLevel1State extends State<MyPageLevel1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: MyPageLevel2()));
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel2 extends StatefulWidget {
  const MyPageLevel2({super.key});

  @override
  State<MyPageLevel2> createState() => _MyPageLevel2State();
}

class _MyPageLevel2State extends State<MyPageLevel2> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: MyPageLevel3());
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class MyPageLevel3 extends StatelessWidget {
  const MyPageLevel3({super.key});

  @override
  Widget build(BuildContext context) {
    String str = Model.of(context)!.title;
    return Text(str);
  }
}
