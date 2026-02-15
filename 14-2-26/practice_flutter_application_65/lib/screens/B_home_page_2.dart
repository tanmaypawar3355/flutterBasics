import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';
import 'package:practice_flutter_application_65/models/A_single_object_model_1.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage2> {
  dynamic data;
  bool isReady = false;

  void getData() async {
    setState(() {
      isReady = false;
    });
    await ApiService()
        .getSingleObjectWithoutModelAPI()
        .then((value) {
          setState(() {
            data = value!;
            isReady = true;
            print(data);
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
          setState(() {
            isReady = false;
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
        title: Text("Single Object Without Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: !isReady
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: ListTile(
                leading: CircleAvatar(child: Text(data['id'].toString())),
                title: Text(data['title'].toString()),
                subtitle: Text(data['body'].toString()),
              ),
            ),
    );
  }
}
