import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_52/models/products_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ProductsModel?> getProductsAPI() async {
    print("object");
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body.toString());
      return ProductsModel.fromJson(data);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductsAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.products!.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.products!.length);
                return Align(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 100,
                      top: 40,
                    ),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 200,
                            child: Image.network(
                              snapshot.data!.products![index].images![0],
                            ),
                          ),
                          Text(
                            snapshot.data!.products![index].title!,
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              width: 250,
                              height: 60,
                              child: Text(
                                snapshot.data!.products![index].description!,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),

                          Container(width: 200, height: 100, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
