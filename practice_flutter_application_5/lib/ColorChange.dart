import 'package:flutter/material.dart';

class ColorChange extends StatefulWidget {
  const ColorChange({super.key});

  @override
  State<ColorChange> createState() => _ColorChangeState();
}

class _ColorChangeState extends State<ColorChange> {
  bool colorBox1 = true;
  bool colorBox2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Color Box"), backgroundColor: Colors.blue),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: colorBox1 ? Colors.red : Colors.black,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (colorBox1 == true) {
                          colorBox1 = false;
                          print(colorBox1);
                        } else {
                          colorBox1 = true;
                          print(colorBox1);
                        }
                      });
                    },
                    child: Text("Color box 1"),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: colorBox2 ? Colors.blue : Colors.black,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (colorBox2 == true) {
                          colorBox2 = false;
                        } else {
                          colorBox2 = true;
                        }
                      });
                    },
                    child: Text("Color box 2"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
