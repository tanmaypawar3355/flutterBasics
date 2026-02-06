import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_57/models/A_post_model_1.dart';
import 'package:practice_flutter_application_57/models/B_photos_model_2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage2> {
  List<PhotosModel> myList = [];
  Future<List<PhotosModel>?> getAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        myList.add(PhotosModel.fromJson(i));
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
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Card(child: Column(children: [

                Text(myList[index].albumId.toString(),),
                Text(myList[index].id.toString(),),
                Text(myList[index].title.toString(),),
                
                Container(width: 300,height: 300,child: Image.network(myList[index].url.toString()),)
                
              ]));
            },
          );
        },
      ),
    );
  }
}
