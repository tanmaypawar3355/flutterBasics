// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:practice_flutter_application_60/models/B_photos_model_2.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage3> {
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        Photos photos = Photos(
          id: i['id'],
          albumId: i['albumId'],
          title: i['title'],
          url: i['url'],
        );

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
            return Center(child: Text("NO DATA"));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Album Id : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(snapshot.data![index].albumId.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Id : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(snapshot.data![index].id.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Title : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(snapshot.data![index].title.toString()),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 300,
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
  int albumId;
  String title;
  String url;
  Photos({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
  });
}
