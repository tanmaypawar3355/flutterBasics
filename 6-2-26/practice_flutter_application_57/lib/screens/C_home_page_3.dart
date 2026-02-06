// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:practice_flutter_application_57/models/A_post_model_1.dart';
import 'package:practice_flutter_application_57/models/B_photos_model_2.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage3> {
  List<Photos> myList = [];
  Future<List<Photos>?> getAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        Photos photos = Photos(id: i['id'], title: i['title'], url: i['url']);
        myList.add(photos);
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
              return Card(
                child: Column(
                  children: [
                    Text(myList[index].id.toString()),
                    Text(myList[index].title.toString()),

                    Container(
                      width: 300,
                      height: 300,
                      child: Image.network(myList[index].url.toString()),
                    ),
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

class Photos {
  int id;
  String title;
  String url;
  Photos({required this.id, required this.title, required this.url});
}
