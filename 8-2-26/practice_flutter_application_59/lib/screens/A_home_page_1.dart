import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_59/models/A_post_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late Future<List<PostModel>?> futureBuilder;
  List<PostModel> myList = [];

  @override
  void initState() {
    super.initState();
    futureBuilder = getPostAPI();
  }

  Future<List<PostModel>?> getPostAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        myList.add(PostModel.fromJson(i));
      }
      return myList;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureBuilder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("ERROR"));
          }

          if (!snapshot.hasData) {
            return Center(child: Text("NO DATA"));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text("User ID : ${snapshot.data![index].userId}"),
                      Text("ID : ${snapshot.data![index].id}"),
                      Text("Title : ${snapshot.data![index].title}"),
                      Text(
                        "Body : ${snapshot.data![index].body}",
                        textAlign: TextAlign.center,
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
