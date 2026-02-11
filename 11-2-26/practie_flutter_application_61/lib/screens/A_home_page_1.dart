import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practie_flutter_application_61/apiServices/API_service.dart';
import 'package:practie_flutter_application_61/models/A_get_single_object_with_model.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  GetSingleObjectWithModel? singleGetWithModel = GetSingleObjectWithModel();
  bool isReady = false;

  void _getSinglePost() {
    isReady = true;
    ApiService().singleObjectWithModel().then((value) {
          setState(() {
            singleGetWithModel = value;
            isReady = false;
          });
        }).onError((error, stackTrace) {
          print(error);
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
                    singleGetWithModel!.userId.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    singleGetWithModel!.title.toString(),
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  subtitle: Text(
                    singleGetWithModel!.body.toString(),
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ),
            ),
    );
  }
}
