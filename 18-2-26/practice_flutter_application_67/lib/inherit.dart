import 'package:flutter/material.dart';
import 'package:practice_flutter_application_67/data.dart';

class MyInherite extends InheritedWidget {
  final Widget child;
  final Database database;

  const MyInherite({super.key, required this.child, required this.database})
    : super(child: child);

  static MyInherite? of(BuildContext context) {
    print("Hiiii");
    return context.dependOnInheritedWidgetOfExactType<MyInherite>();
  }

  @override
  bool updateShouldNotify(MyInherite oldWidget) {
    print("Returning true");
    print(oldWidget.database.name());
    return true;
  }
}
