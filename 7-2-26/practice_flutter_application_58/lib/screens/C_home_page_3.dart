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
  late Future<List<Photos>?> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = photosMyModelClassAPI();
  }

  Future<List<Photos>?> photosMyModelClassAPI() async {
    List<Photos> myList = [];
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        Photos photos = Photos(id: i['id'], title: i['title'], url: i['url']);

        myList.add(photos);
      }
      print(myList.length);
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text("ID : ${snapshot.data![index].id}"),
                        const SizedBox(height: 10),
                        Text("Title : ${snapshot.data![index].title}"),
                        const SizedBox(height: 10),
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.network(
                            snapshot.data![index].url.toString(),
                          ),
                        ),
                      ],
                    ),
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
