import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';
import 'package:practice_flutter_application_66/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_66/models/C_multiple_object_model_3.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage3> {
  List<MultipleObjectModel> myList = [];
  bool isNotReady = false;

  void getData() async {
    setState(() {
      isNotReady = true;
    });
    ApiService()
        .getMultipleObjectWithModel()
        .then((value) {
          setState(() {
            myList = value!;
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
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return 
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(myList[index].id.toString()),
                        ),
                        title: Text(
                          myList[index].title.toString(),
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(
                          myList[index].body.toString(),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 173, 33, 243),
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
