import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';
import 'package:practice_flutter_application_66/models/A_single_object_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  SingleObjectModel model = SingleObjectModel();
  bool isNotReady = false;

  void getData() async {
    setState(() {
      isNotReady = true;
    });
    ApiService()
        .getSingleObjectWithModel()
        .then((value) {
          setState(() {
            model = value!;
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
                    leading: CircleAvatar(child: Text(model.id.toString())),
                    title: Text(
                      model.title.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Text(
                      model.body.toString(),
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
