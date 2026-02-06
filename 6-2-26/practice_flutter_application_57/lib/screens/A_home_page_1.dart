import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_57/models/A_post_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List<PostModel> myList = [];
  Future<List<PostModel>?> getAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        myList.add(PostModel.fromJson(i));
      }
      return myList;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    getAPI();
    return Scaffold(
      body: FutureBuilder(
        future: getAPI(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Card(child: Column(children: [

                Text(myList[index].userId.toString(),),
                Text(myList[index].id.toString(),),
                Text(myList[index].title.toString(),),
                Text(myList[index].body.toString(),),
                
              ]));
            },
          );
        },
      ),
    );
  }
}
