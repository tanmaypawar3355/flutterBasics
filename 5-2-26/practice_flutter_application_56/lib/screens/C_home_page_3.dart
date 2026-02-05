// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<Photos> myList = [];
  late Future<List<Photos>?> futureBuilder;
  @override
  void initState() {
    super.initState();
    futureBuilder = getPhotosAPI();
  }

  Future<List<Photos>?> getPhotosAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
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
            return Center(child: Text("ERROR"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Id : ${snapshot.data![index].id}"),
                      Text("Title : ${snapshot.data![index].title}"),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.network(snapshot.data![index].title),
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

class Photos {
  int id;
  String title;
  String url;

  Photos({required this.id, required this.title, required this.url});
}
