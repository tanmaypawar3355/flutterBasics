import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_51/models/B_photos_model_2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomePage2> {
  List<PhotosModel> myList = [];
  Future<List<PhotosModel>> getPhotosAPI() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        myList.add(PhotosModel.fromJson(i));
      }
      print(myList.length);
      return myList;
    } else {
      return myList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPhotosAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasData && myList.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(myList[index].title.toString()),
                      Container(
                        height: 500,
                        width: 500,
                        child: Image.network(
                          myList[index].thumbnailUrl.toString(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
