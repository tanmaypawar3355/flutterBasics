import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_58/models/A_post_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late Future<List<PostModel>?> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = getAPI();
  }

  Future<List<PostModel>?> getAPI() async {
    List<PostModel> myList = [];

    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      for (var i in data) {
        myList.add(PostModel.fromJson(i));
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
                padding: const EdgeInsets.all(50.0),
                child: Card(
                  color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(" ID : ${snapshot.data![index].id.toString()}"),
                        const SizedBox(height: 10),
                        Text(
                          " User ID : ${snapshot.data![index].userId.toString()}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          " Title : ${snapshot.data![index].title.toString()}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          " Body : ${snapshot.data![index].body.toString()}",
                          textAlign: TextAlign.center,
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
