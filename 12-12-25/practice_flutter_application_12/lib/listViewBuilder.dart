import 'package:flutter/material.dart';

class MyListViewBuilder extends StatefulWidget {
  const MyListViewBuilder({super.key});

  @override
  State<MyListViewBuilder> createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  List names = [];
  List city = [];
  List hometown = [];

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _controller1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                hintText: "Enter your name",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _controller2,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                hintText: "Enter your city",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _controller3,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                hintText: "Enter your hometown",
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_controller1.text.toString().isNotEmpty &&
                    _controller2.text.toString().isNotEmpty &&
                    _controller3.text.toString().isNotEmpty) {
                  names.add(_controller1.text);
                  city.add(_controller2.text);
                  hometown.add(_controller3.text);
                }
                _controller1.clear();
                _controller2.clear();
                _controller3.clear();
              });
            },
            child: Text("ADD"),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 100,
                  color: const Color.fromARGB(255, 194, 193, 193),
                  margin: EdgeInsets.symmetric(horizontal: 250, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(names[index]),
                      Text(city[index]),
                      Text(hometown[index]),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
