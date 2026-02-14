import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  GetSingleObjectModel model = GetSingleObjectModel();
  bool isReady = false;
  void getData() async {
    isReady = true;
    await ApiService()
        .getSingleObjectWithModel()
        .then((value) {
          print(value);
          setState(() {
            model = value!;
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
        title: Text("Single Object With Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: isReady
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.id.toString()),
                  Text(model.userId.toString()),
                  Text(model.title.toString()),
                  Text(model.body.toString()),
                ],
              ),
            ),
    );
  }
}
