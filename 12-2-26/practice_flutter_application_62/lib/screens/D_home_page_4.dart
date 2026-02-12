import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  var data;
  bool isReady = false;
  void _getMultipleData() {
    isReady = false;
    APIService().getMultipleObjectWithoutModel().then((value) {
      setState(() {
        data = value;
        print(data.length);
        isReady = true;
      });
    });
  }

  @override
  void initState() {
    _getMultipleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady == false
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(data[index]['userId'].toString()),
                          Text(data[index]['id'].toString()),
                          Text(data[index]['title'].toString()),
                          Text(data[index]['body'].toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
