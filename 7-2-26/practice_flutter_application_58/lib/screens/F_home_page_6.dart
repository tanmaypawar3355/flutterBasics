import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_58/models/F_products_models_6.dart';

class HomePage6 extends StatefulWidget {
  const HomePage6({super.key});

  @override
  State<HomePage6> createState() => _HomePage6State();
}

class _HomePage6State extends State<HomePage6> {
  late Future<ProductsModel?>? futureBuilder;

  @override
  void initState() {
    super.initState();
    futureBuilder = productsAPI();
  }

  Future<ProductsModel?>? productsAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("200");
      return ProductsModel.fromJson(data);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductsModel?>(
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

          return  ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.products!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: 380,
                        height: 500,
                        child: Card(
                          elevation: 25,
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: Image.network(
                                    snapshot.data!.products![index].images![0],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    Text(
                                      "₹  ${snapshot.data!.products![index].price.toString()}",
                                      style: TextStyle(fontSize: 20),
                                    ),

                                    const SizedBox(width: 20),
                                    Text(
                                      "${snapshot.data!.products![index].discountPercentage.toString()} % OFF",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                Container(
                                  width: 300,
                                  child: Text(
                                    snapshot.data!.products![index].title
                                        .toString(),
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  snapshot.data!.products![index].brand
                                      .toString(),
                                ),
                                const SizedBox(height: 10),

                                Container(
                                  width: 300,
                                  child: Text(
                                    snapshot.data!.products![index].description
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          
        },
      ),
    );
  }
}
