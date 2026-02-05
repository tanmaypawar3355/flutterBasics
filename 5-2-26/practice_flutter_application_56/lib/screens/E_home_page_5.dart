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
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Id : ${snapshot.data![index].id.toString()}"),
                          Text(
                            "Name : ${snapshot.data![index].name.toString()}",
                          ),
                          Text(
                            "Username : ${snapshot.data![index].username.toString()}",
                          ),
                          Text(
                            "Email : ${snapshot.data![index].email.toString()}",
                          ),

                          const SizedBox(height: 20),

                          Card(
                            color: Colors.grey[400],
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(20),
                              child: Column(
                                children: [
                                  Text("Address"),
                                  Text(
                                    "Street : ${snapshot.data![index].address!.street.toString()}",
                                  ),
                                  Text(
                                    "Suite : ${snapshot.data![index].address!.suite.toString()}",
                                  ),
                                  Text(
                                    "City : ${snapshot.data![index].address!.city.toString()}",
                                  ),
                                  Text(
                                    "Zipcode : ${snapshot.data![index].address!.zipcode.toString()}",
                                  ),

                                  const SizedBox(height: 30),

                                  Card(
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Text("Geo"),
                                          Text(
                                            "Lat : ${snapshot.data![index].address!.geo!.lat.toString()}",
                                          ),
                                          Text(
                                            "Lng : ${snapshot.data![index].address!.geo!.lng.toString()}",
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

                          Text(
                            "Phone : ${snapshot.data![index].phone.toString()}",
                          ),
                          Text(
                            "Website : ${snapshot.data![index].website.toString()}",
                          ),

                          const SizedBox(height: 30),

                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text("Company"),
                                  Text(
                                    "Name : ${snapshot.data![index].company!.name.toString()}",
                                  ),
                                  Text(
                                    "Catch phrase : ${snapshot.data![index].company!.catchPhrase.toString()}",
                                  ),
                                  Text(
                                    "Bs : ${snapshot.data![index].company!.bs.toString()}",
                                  ),
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
