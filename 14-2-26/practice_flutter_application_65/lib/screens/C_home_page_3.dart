import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';
import 'package:practice_flutter_application_65/models/C_multiple_object_model_3.dart';

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
    ApiService()
        .getMultipleObjectWithModelAPI()
        .then((value) {
          setState(() {
            myList = value!;
            isReady = true;
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
        title: Text("Multiple Object With Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: !isReady
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(myList[index].id.toString()),
                      ),
                      title: Text(
                        myList[index].title.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      subtitle: Text(
                        myList[index].body.toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
