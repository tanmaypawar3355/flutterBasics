import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';
import 'package:practice_flutter_application_66/models/A_single_object_model_1.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage2> {
  dynamic data;
  bool isNotReady = false;

  void getData() async {
    setState(() {
      isNotReady = true;
    });
    ApiService()
        .getSingleObjectWithoutModel()
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
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(data['id'].toString())),
                    title: Text(
                      data['title'].toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Text(
                      data['body'].toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 173, 33, 243),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
