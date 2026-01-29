import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice_flutter_application_50/models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  List<PostModel> myList = [];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("Hiiii");
      for (Map i in data) {
        myList.add(PostModel.fromJson(i));
      }
      print(myList.length);
      return myList;
    } else {
      return myList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(myList.length);
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "User Id : ",
                            style: TextStyle(fontSize: 15),
                            children: [
                              TextSpan(text: myList[index].userId.toString()),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Id : ",
                            style: TextStyle(fontSize: 15),
                            children: [
                              TextSpan(text: myList[index].id.toString()),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Title : ",
                            style: TextStyle(fontSize: 15),
                            children: [
                              TextSpan(text: myList[index].title.toString()),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Body : ",
                            style: TextStyle(fontSize: 15),
                            children: [
                              TextSpan(text: myList[index].body.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
