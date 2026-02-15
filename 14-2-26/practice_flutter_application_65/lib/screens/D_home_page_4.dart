import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';
import 'package:practice_flutter_application_65/models/C_multiple_object_model_3.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage4> {
  dynamic data;
  bool isReady = false;

  void getData() async {
    setState(() {
      isReady = false;
    });
    await ApiService()
        .getMultipleObjectWithoutModelAPI()
        .then((value) {
          setState(() {
            data = value;
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
        title: Text("Multiple Object Without Model"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: !isReady
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(data[index]['id'].toString()),
                      ),
                      title: Text(
                        data[index]["title"].toString(),
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      subtitle: Text(
                        data[index]["body"].toString(),
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
