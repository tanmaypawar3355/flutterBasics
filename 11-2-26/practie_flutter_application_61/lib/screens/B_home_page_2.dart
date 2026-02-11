import 'package:flutter/material.dart';
import 'package:practie_flutter_application_61/apiServices/API_service.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  dynamic data;
  bool isReady = false;
  void _getSinglePost() {
    isReady = true;
    ApiService().singleObjectWithoutModel().then((value) {
      setState(() {
        data = value;
        isReady = false;
      });
    });
  }

  @override
  void initState() {
    _getSinglePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady == true
          ? Center(child: CircularProgressIndicator())
          : Card(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListTile(
                  leading: Text(
                    data['id'].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    data['title'].toString(),
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  subtitle: Text(
                    data['body'].toString(),
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ),
            ),
    );
  }
}
