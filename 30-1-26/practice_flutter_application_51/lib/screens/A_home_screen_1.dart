import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_51/models/A_post_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
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
          print(myList.length);
          if (snapshot.hasData) {
            if (myList.isNotEmpty) {
              return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      shadowColor: Colors.black,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 20),
                            Text(myList[index].userId.toString()),
                            const SizedBox(height: 20),
                            Text(myList[index].title.toString()),
                            const SizedBox(height: 20),
                            Text(myList[index].body.toString()),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
