import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class _HomePage7State extends State<HomePage7> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var data;

  Future<bool> postAPI(String username, String password) async {
    final response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),

              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),

              GestureDetector(
                onTap: () async {
                  bool result = await postAPI(
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  );

                  if (result) {
                    print(data);
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.grey[300],
                  child: Center(child: Text("Login")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
