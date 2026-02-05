import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage5> {
  List myList = [];

  late Future<dynamic> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = getNestedWithoutModelAPI();
  }

  Future<dynamic> getNestedWithoutModelAPI() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(data.length);
      print(data);

      return data;
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
            return Center(child: Text("ERROR"));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index] as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Id : ${user['id']}"),
                          Text("Name : ${user['name']}"),
                          Text("Username : ${user['username']}"),
                          Text("Email : ${user['email']}"),

                          const SizedBox(height: 20),

                          Card(
                            color: Colors.grey[400],
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Text("Address"),
                                  Text("Street : ${user['address']['street']}"),
                                  Text("Suite : ${user['address']['suite']}"),
                                  Text("City : ${user['address']['city']}"),
                                  Text(
                                    "Zipcode : ${user['address']['zipcode']}",
                                  ),

                                  const SizedBox(height: 30),

                                  Card(
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          const Text("Geo"),
                                          Text(
                                            "Lat : ${user['address']['geo']['lat']}",
                                          ),
                                          Text(
                                            "Lng : ${user['address']['geo']['lng']}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Text("Phone : ${user['phone']}"),
                          Text("Website : ${user['website']}"),

                          const SizedBox(height: 30),

                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const Text("Company"),
                                  Text("Name : ${user['company']['name']}"),
                                  Text(
                                    "Catch phrase : ${user['company']['catchPhrase']}",
                                  ),
                                  Text("Bs : ${user['company']['bs']}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Text("Hii");
        },
      ),
    );
  }
}
