import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  dynamic data;
  bool isReady = false;
  void getData() async {
    isReady = true;
    await ApiService()
        .getSingleObjectWithoutModel()
        .then((value) {
          setState(() {
            data = value!;
            isReady = false;
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
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
      body: isReady 
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data['id'].toString()),
                  Text(data['userId'].toString()),
                  Text(data['title'].toString()),
                  Text(data['body'].toString()),
                ],
              ),
            ),
    );
  }
}
