import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';
import 'package:practice_flutter_application_62/models/C_get_multiple_object_with_model_3.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<GetMultipleObjectWithModel>? myList = [];
  bool isReady = false;

  void _getMultipleData() {
    isReady = false;
    APIService()
        .getMultipleObjectWithoutModel()
        .then((value) {
          setState(() {
            myList = value;
            isReady = true;
          });
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }

  @override
  void initState() {
    _getMultipleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady == false
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: myList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(myList![index].id.toString()),
                          Text(myList![index].userId.toString()),
                          Text(myList![index].title.toString()),
                          Text(myList![index].body.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
