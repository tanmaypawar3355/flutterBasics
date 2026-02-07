import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_58/models/D_users_model_4.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  late Future<dynamic> futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = userWithoutModelClassAPI();
  }

  Future<dynamic> userWithoutModelClassAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());

      print(data.length);

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
            return Center(child: Text("NO DATA"));
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Resusable(data: snapshot.data, index: index);
            },
          );
        },
      ),
    );
  }
}

class Resusable extends StatelessWidget {
  dynamic data;
  int index;

  Resusable({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Id : ${data![index]['id'].toString()}"),
              Text("Name : ${data![index]['name'].toString()}"),
              Text("Username : ${data![index]['username'].toString()}"),
              Text("Email : ${data![index]['email'].toString()}"),

              const SizedBox(height: 20),

              Card(
                color: Colors.grey[400],
                child: Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Column(
                    children: [
                      Text("Address"),
                      Text(
                        "Street : ${data![index]['address']['street'].toString()}",
                      ),
                      Text("Suite : ${data![index]['address']['suite'].toString()}"),
                      Text("City : ${data![index]['address']['city'].toString()}"),
                      Text(
                        "Zipcode : ${data![index]['address']['zipcode'].toString()}",
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
                                "Lat : ${data![index]['address']['geo']['lat'].toString()}",
                              ),
                              Text(
                                "Lng : ${data![index]['address']['geo']['lng'].toString()}",
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

              Text("Phone : ${data![index]['phone'].toString()}"),
              Text("Website : ${data![index]['website'].toString()}"),

              const SizedBox(height: 30),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Company"),
                      Text("Name : ${data![index]['company']['name'].toString()}"),
                      Text(
                        "Catch phrase : ${data![index]['company']['catchPhrase'].toString()}",
                      ),
                      Text("Bs : ${data![index]['company']['bs'].toString()}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
