import 'package:flutter/material.dart';

class MyListViewBuilder extends StatefulWidget {
  const MyListViewBuilder({super.key});

  @override
  State<MyListViewBuilder> createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  TextEditingController _TEC1 = TextEditingController();
  TextEditingController _TEC2 = TextEditingController();
  TextEditingController _TEC3 = TextEditingController();
  int counter = 0;

  List list1 = [];
  List list2 = [];
  List list3 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _TEC1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text("Enter your name"),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _TEC2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your city",
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _TEC3,
                decoration: const InputDecoration(
                  hintText: "Enter your city",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                  if (_TEC1.text.isNotEmpty &&
                      _TEC2.text.isNotEmpty &&
                      _TEC3.text.isNotEmpty) {
                    list1.add(_TEC1.text.toString());
                    list2.add(_TEC2.text.toString());
                    list3.add(_TEC3.text.toString());
                  }
                  _TEC1.clear();
                  _TEC2.clear();
                  _TEC3.clear();
                });
              },
              child: Text("ADD"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list1.length,
                itemBuilder: (context, index) {
                  Color myColor = index % 2 == 0
                      ? const Color.fromARGB(255, 211, 209, 209)
                      : const Color.fromARGB(255, 168, 181, 198)!;
                  return Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                      color: myColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 200, vertical: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(list1[index]),
                          Text(list2[index]),
                          Text(list3[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
