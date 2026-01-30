// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  late Future<void> futureBuild;

  @override
  void initState() {
    super.initState();
    futureBuild = getUserAPI();
  }

  var data;
  Future<dynamic> getUserAPI() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUserAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                print(index);
                return ReusableCard(data: data, index: index);
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  var data;
  int index;
  ReusableCard({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 40),
      child: Card(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            children: [
              Text("Id : ${data[index]['id']}"),
              Text("Name : ${data[index]['name']}"),
              Text("Username : ${data[index]['username']}"),
              Text("Email : ${data[index]['email']}"),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("Address"),
                        Text("Street : ${data[index]['address']['street']}"),
                        Text("Suite : ${data[index]['address']['suite']}"),
                        Text("City : ${data[index]['address']['city']}"),
                        Text("Zipcode : ${data[index]['address']['zipcode']}"),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Card(
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text('Geo'),
                                  Text(
                                    "Lat : ${data[index]['address']['geo']['lat']}",
                                  ),
                                  Text(
                                    "Lng : ${data[index]['address']['geo']['lng']}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Text("Phone : ${data[index]['phone']}"),
              Text("Webiste : ${data[index]['website']}"),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("Company"),
                        Text("Name : ${data[index]['company']['name']}"),
                        Text(
                          "Catch phrase : ${data[index]['company']['catchPhrase']}",
                        ),
                        Text("Bs : ${data[index]['company']['bs']}"),
                      ],
                    ),
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
