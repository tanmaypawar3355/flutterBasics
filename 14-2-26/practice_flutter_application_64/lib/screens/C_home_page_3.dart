import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/models/C_multiple_object_model_3.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<GetMultipleObjectModel> myList = [];
  bool isReady = false;
  void getData() async {
    setState(() {
      isReady = false;
    });
    await ApiService()
        .getMultipleObjectWithModel()
        .then((value) {
          print(value);
          if (value != null) {
            setState(() {
              myList = value;
              print(myList.length);
              isReady = true;
            });
          }
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
        title: Text("Multiple Object With Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: !isReady
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: myList.isEmpty ? 0 : myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(myList[index].id.toString()),
                      ),
                      title: Text(
                        myList[index].title.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        myList[index].body.toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
