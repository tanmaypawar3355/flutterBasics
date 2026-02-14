import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';
import 'package:practice_flutter_application_65/models/A_single_object_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  SingleObjectModel model = SingleObjectModel();

  void getData() async {
    await ApiService()
        .getSingleObjectWithModelAPI()
        .then((value) {
          setState(() {
            model = value!;
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
        title: Text("Single Object Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: ListTile(
          leading: CircleAvatar(child: Text(model.id.toString())),
          title: Text(model.title.toString()),
          subtitle: Text(model.body.toString()),
        ),
      ),
    );
  }
}
