import 'package:flutter/material.dart';
import 'package:practie_flutter_application_61/apiServices/API_service.dart';
import 'package:practie_flutter_application_61/models/C_get_multiple_object_with_model.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<GetMultipleObjectWithModel>? myList = [];
  bool isReady = false;
  void _getMultiplePost() {
    isReady = true;
    ApiService()
        .multipleObjectWithModel()
        .then((value) {
          setState(() {
            myList = value!;
            isReady = false;
          });
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }

  @override
  void initState() {
    _getMultiplePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: myList!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text(
                          myList![index].id.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      title: Text(
                        myList![index].title.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      subtitle: Text(
                        myList![index].body.toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
