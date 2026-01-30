import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_51/models/C_photos_model_3.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  late Future<List<Photos>> futureBuild;
  @override
  void initState() {
    super.initState();
    futureBuild = getPhotosAPI();
  }

  List<Photos> myList = [];
  Future<List<Photos>> getPhotosAPI() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        myList.add(photos);
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
        future: futureBuild,
        builder: (context, snapshot) {
          print("Lenght : ${myList.length}");
          if (snapshot.hasData && myList.isNotEmpty) {
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.abc)),

                  title: Text(myList[index].id.toString()),
                  subtitle: Text(myList[index].title),
                );
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
