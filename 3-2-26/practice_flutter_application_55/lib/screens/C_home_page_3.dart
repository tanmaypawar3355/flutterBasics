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
  late Future<void> futureBuilder;
  @override
  void initState() {
    super.initState();
    futureBuilder = getPhotosApiMyModelClass();
  }

  List<Photos> myList = [];
  Future<List<Photos>?> getPhotosApiMyModelClass() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    final data = jsonDecode(response.body.toString());

    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(id: i["id"], title: i["title"], url: i["url"]);
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

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text("Album Id  : ${myList[index].id}"),
                        const SizedBox(height: 20),
                        Text(
                          "Title : ${myList[index].title}",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            myList[index].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Icon(Icons.dnd_forwardslash_outlined);
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
