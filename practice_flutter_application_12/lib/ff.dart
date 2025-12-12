import 'package:flutter/material.dart';
// import 'package:textefield_listview_builder_add_data/bye.dart';
// import 'package:textefield_listview_builder_add_data/hi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Byeeeee(),
    );
  }
}

class Byeeeee extends StatefulWidget {
  const Byeeeee({super.key});

  @override
  State<Byeeeee> createState() => _ByeeeeeState();
}

class _ByeeeeeState extends State<Byeeeee> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  List names1 = [];
  List names2 = [];
  List names3 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField ListViewBuilder"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(199, 200, 249, 1),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            width: 300,
            height: 50,
            child: TextField(
                controller: _controller1,
                decoration: const InputDecoration(
                    hintText: "Enter you name",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.cyan)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ))),
          ),
          const SizedBox(height: 40),
          SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: _controller2,
                decoration: const InputDecoration(
                    hintText: "Enter your DOB",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.cyan))),
              )),
          const SizedBox(height: 40),
          SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: _controller3,
                decoration: const InputDecoration(
                    hintText: "Enter your city",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.cyan))),
              )),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 0, 0, 0)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 206, 228, 246))),
            onPressed: () {
              if (_controller1.text.isNotEmpty &&
                  _controller2.text.isNotEmpty &&
                  _controller3.text.isNotEmpty) {
                names1.add(_controller1.text.toString());
                names2.add(_controller2.text.toString());
                names3.add(_controller3.text.toString());
                setState(() {
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                });
              }
            },
            child: const Text(
              " Add ",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: names1.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                height: 100,
                margin: const EdgeInsets.only(
                    left: 150.0, right: 150.0, bottom: 10, top: 10),
                color: const Color.fromARGB(255, 206, 228, 246),
                child: Column(
                  children: [
                    Text(
                      names1[index],
                      // .toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      names2[index],
                      // text2.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      names3[index],
                      // text3.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
