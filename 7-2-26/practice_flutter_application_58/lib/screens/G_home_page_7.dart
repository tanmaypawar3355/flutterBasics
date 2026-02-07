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

  Future<bool> postLoginAPI(String username, String password) async {
    http.Response response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  bool result = await postLoginAPI(
                    usernameController.text.toString(),
                    passwordController.text.toString(),
                  );

                  if (result) {
                    print("Success");
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.grey[400],
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
