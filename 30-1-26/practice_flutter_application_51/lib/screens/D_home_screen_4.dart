import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_51/models/D_user_model_4.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  late Future<List<UsersModel>> futureBuild;

  @override
  void initState() {
    super.initState();

    futureBuild = getUserAPI();
  }

  List<UsersModel> myList = [];

  Future<List<UsersModel>> getUserAPI() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        myList.add(UsersModel.fromJson(i));
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
          if (snapshot.hasData && myList.isNotEmpty) {
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100.0,
                    vertical: 30,
                  ),
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 20,
                    borderOnForeground: true,
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),

                          Text("Name : ${myList[index].name}"),
                          Text("UserName : ${myList[index].username}"),
                          Text("Email : ${myList[index].email}"),
                          const SizedBox(height: 20),
                          Card(
                            shadowColor: Colors.black,
                            elevation: 15,
                            color: Colors.grey[350],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text("Address : "),
                                  Text(
                                    "Street : ${myList[index].address!.street}",
                                  ),
                                  Text(
                                    "Suite : ${myList[index].address!.suite}",
                                  ),
                                  Text("City : ${myList[index].address!.city}"),
                                  Text(
                                    "Zipcode : ${myList[index].address!.zipcode}",
                                  ),
                                  const SizedBox(height: 20),
                                  Card(
                                    shadowColor: Colors.black,
                                    elevation: 15,
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Text("Geo : "),
                                          Text(
                                            "Lat : ${myList[index].address!.geo!.lat}",
                                          ),
                                          Text(
                                            "Street : ${myList[index].address!.geo!.lng}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Phone : ${myList[index].phone}"),
                          Text("Webiste : ${myList[index].website}"),
                          const SizedBox(height: 20),
                          Card(
                            shadowColor: Colors.black,
                            elevation: 15,
                            color: Colors.grey[350],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text("Company : "),
                                  Text("Name : ${myList[index].company!.name}"),
                                  Text(
                                    "Catch Phrase : ${myList[index].company!.catchPhrase}",
                                  ),
                                  Text("Bs : ${myList[index].company!.bs}"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
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
