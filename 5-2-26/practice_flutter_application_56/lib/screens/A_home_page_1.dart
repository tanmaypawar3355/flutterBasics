import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_56/models/A_post_model.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late Future<dynamic> futureBuilder;
  List<PostModel> myList = [];

  @override
  void initState() {
    super.initState();
    futureBuilder = getAPI();
  }

  Future<dynamic> getAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        myList.add(PostModel.fromJson(i));
      }
      print("Hiiii");
      return myList;
      // return data;
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
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [Text("User Id : ${myList[index].userId}"),
                  Text("Id : ${myList[index].id}"),
                  Text("Title : ${myList[index].title}"),
                  Text("Body : ${myList[index].body}")
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
