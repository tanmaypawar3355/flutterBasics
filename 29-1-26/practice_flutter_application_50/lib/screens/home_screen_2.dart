import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_50/models/post_model.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
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
        future: getPostAPI(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RichText(
                      //   text: TextSpan(
                      //     text: "User Id :",
                      //     children: [
                      //       TextSpan(text: myList[index].userId.toString()),
                      //     ],
                      //   ),
                      // ),
                      RichText(
                        text: TextSpan(
                          text: "Id : ",
                          children: [
                            TextSpan(text: "${myList[index].id.toString()}\n"),
                          ],
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          text: "Title: ",
                          children: [
                            TextSpan(
                              text: "${myList[index].title.toString()}\n",
                            ),
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
              );
            },
          );
        },
      ),
    );
  }
}
