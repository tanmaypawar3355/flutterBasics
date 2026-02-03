import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_55/models/A_user_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late Future<List<UserModel>?> futureBuilder;
  @override
  void initState() {
    super.initState();
    futureBuilder = getAPI();
  }

  List<UserModel> myList = [];
  Future<List<UserModel>?> getAPI() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    dynamic data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        myList.add(UserModel.fromJson(i));
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
                        Text("User Id  : ${snapshot.data![index].userId}"),
                        const SizedBox(height: 20),
                        Text("Id : ${snapshot.data![index].id}"),
                        const SizedBox(height: 20),
                        Text(
                          "Title : ${snapshot.data![index].title}",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Body : ${snapshot.data![index].body}",
                          textAlign: TextAlign.center,
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
