import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  dynamic data;
  bool isReady = false;

  void getData() {
    setState(() {
      isReady = true;
    });
    ApiService()
        .getMultipleObjectWithoutModel()
        .then((value) {
          setState(() {
            data = value;
            isReady = false;
          });
        })
        .onError((error, stackTrace) {
          setState(() {
            isReady = true;
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
      body: isReady
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(data[index]['id'].toString()),
                      ),
                      title: Text(
                        data[index]['title'].toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        data[index]['body'].toString(),
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
