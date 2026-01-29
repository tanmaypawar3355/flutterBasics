import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_50/models/post_model.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  List<PostModel> myList = [];

  Future<List<PostModel>> getPostAPI() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        myList.add(PostModel.fromJson(i));
      }
      return myList;
    } else {
      return myList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Id : ",
                              children: [
                                TextSpan(text: myList[index].id.toString()),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: "Title : ",
                              children: [
                                TextSpan(text: myList[index].title.toString()),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: "Body : ",
                              children: [
                                TextSpan(text: myList[index].body.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
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
