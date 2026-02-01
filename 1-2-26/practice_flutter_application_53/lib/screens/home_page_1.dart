import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_53/models/products_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  Future<ProductsModel?> getProductsAPI() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 200,
                                    child: Image.network(
                                      snapshot
                                          .data!
                                          .products![index]
                                          .images![0],
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
                                      snapshot
                                          .data!
                                          .products![index]
                                          .description
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[700],
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          child: RatingBarIndicator(
                                            rating: snapshot
                                                .data!
                                                .products![index]
                                                .rating!
                                                .toDouble(),
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                            itemCount: 5,
                                            itemSize: 30,
                                            direction: Axis.horizontal,
                                            unratedColor: Colors.grey[400],
                                          ),
                                        ),

                                        Container(
                                          height: 15,
                                          child: Text(
                                            "( ${snapshot.data!.products![index].rating!} )",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
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
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
