import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_56/models/B_photos_model_2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage2> {
  List<PhotosModel> myList = [];
  late Future<List<PhotosModel>?> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = getPhotosAPI();
  }

  Future<List<PhotosModel>?> getPhotosAPI() async {
    Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        myList.add(PhotosModel.fromJson(i));
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Album Id : ${snapshot.data![index].albumId}"),
                      Text("Id : ${snapshot.data![index].id}"),
                      Text("Title : ${snapshot.data![index].title}"),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.network("${snapshot.data![index].title}"),
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
