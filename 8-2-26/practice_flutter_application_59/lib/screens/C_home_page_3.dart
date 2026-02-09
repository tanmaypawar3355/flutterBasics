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
    futureBuilder = getPhotosMyModelClassAPI();
  }

  Future<List<Photos>?> getPhotosMyModelClassAPI() async {
    List<Photos> myList = [];
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        Photos photos = Photos(
          id: i['id'],
          title: i['title'],
          url: i['url'],
          albumId: i['albumId'],
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

          if(!snapshot.hasData) {
            return Center(child: Text("NO-DATA")); 
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text("Album ID : ${snapshot.data![index].albumId}"),
                      Text("ID : ${snapshot.data![index].id}"),
                      Text("Title : ${snapshot.data![index].title}"),

                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.network(snapshot.data![index].url),
                      )
                      
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
