import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  var data;
  bool isReady = false;
  void _getMultipleData() async {
    isReady = false;
    APIService().getSingleObjectWithoutModel().then((value) {
      setState(() {
        data = value;
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
          : Column(
              children: [
                Text(data['userId'].toString()),
                Text(data['id'].toString()),
                Text(data['title'].toString()),
                Text(data['body'].toString()),
              ],
            ),
    );
  }
}
