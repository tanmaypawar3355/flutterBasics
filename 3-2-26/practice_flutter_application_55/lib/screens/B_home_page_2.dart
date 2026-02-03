import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_55/models/B_photos_model_2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  late Future<List<PhotosModel>?> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = getPhotosAPI();
  }

  List<PhotosModel> myList = [];

  Future<List<PhotosModel>?> getPhotosAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
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

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
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
                        Text("Album Id  : ${snapshot.data![index].albumId}"),
                        const SizedBox(height: 20),
                        Text("Id : ${snapshot.data![index].id}"),
                        const SizedBox(height: 20),
                        Text(
                          "Title : ${snapshot.data![index].title}",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            snapshot.data![index].url.toString(),
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
