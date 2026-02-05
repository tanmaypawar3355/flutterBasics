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
  late Future<dynamic> futureBuilder;
  @override
  void initState() {
    super.initState();
    futureBuilder = getNestedWithoutModelClass();
  }

  var data;

  Future<dynamic> getNestedWithoutModelClass() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print(data);
      return data;
    }
    // return null;
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

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30,
                  ),
                  child: ReusableCard(data: data, index: index),
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
class ReusableCard extends StatelessWidget {
  final List data;
  final int index;

  const ReusableCard({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final user = data[index];

    return Card(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name : ${user['name']}"),
            const SizedBox(height: 10),
            Text("Username : ${user['username']}"),
            const SizedBox(height: 10),
            Text("Email : ${user['email']}"),

            const SizedBox(height: 20),

            Card(
              color: Colors.grey[400],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Address"),
                    const SizedBox(height: 10),
                    Text("Street : ${user['address']['street']}"),
                    Text("Suite : ${user['address']['suite']}"),
                    Text("City : ${user['address']['city']}"),
                    Text("Zipcode : ${user['address']['zipcode']}"),

                    const SizedBox(height: 10),

                    Card(
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Geo"),
                            Text("Lat : ${user['address']['geo']['lat']}"),
                            Text("Lng : ${user['address']['geo']['lng']}"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text("Phone : ${user['phone']}"),
            Text("Website : ${user['website']}"),

            const SizedBox(height: 30),

            Card(
              color: Colors.grey[400],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Company"),
                    Text("Company Name : ${user['company']['name']}"),
                    Text("Catch Phrase : ${user['company']['catchPhrase']}"),
                    Text("BS : ${user['company']['bs']}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
