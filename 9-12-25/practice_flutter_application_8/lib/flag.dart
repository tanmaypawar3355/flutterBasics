import 'package:flutter/material.dart';

class Flag extends StatefulWidget {
  const Flag({super.key});

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      if (counter >= 8) counter = 0;
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 190),
              if (counter >= 4)
                Container(color: Colors.black, width: 10, height: 430),
              Column(
                children: [
                  if (counter >= 7)
                    Container(color: Colors.deepOrange, width: 210, height: 40),

                  if (counter >= 6)
                    Container(
                      color: Colors.white,
                      width: 210,
                      height: 40,
                      padding: EdgeInsets.all(3),
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Ashoka_Chakra_1.svg/1024px-Ashoka_Chakra_1.svg.png",
                      ),
                    ),

                  if (counter >= 5)
                    Container(color: Colors.green, width: 210, height: 40),
                  const SizedBox(height: 310),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  if (counter >= 3)
                    Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),

                  if (counter >= 2)
                    Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),

                  if (counter >= 1)
                    Container(
                      width: 350,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
