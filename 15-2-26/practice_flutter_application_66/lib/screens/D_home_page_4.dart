import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';
import 'package:practice_flutter_application_66/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_66/models/C_multiple_object_model_3.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage4> {
  dynamic data;
  bool isNotReady = false;

  void getData() async {
    setState(() {
      isNotReady = true;
    });
    ApiService()
        .getMultipleObjectWithoutModel()
        .then((value) {
          setState(() {
            data = value!;
            isNotReady = false;
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
          setState(() {
            isNotReady = true;
          });
        });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Object With Model"),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      body: isNotReady
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(data[index]['id'].toString()),
                        ),
                        title: Text(
                          data[index]['title'].toString(),
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(
                          data[index]['body'].toString(),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 237, 34, 34),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
