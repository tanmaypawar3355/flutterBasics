import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class _HomePage7State extends State<HomePage7> {
  //
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> postLoginAPI(String username, password) async {
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
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(border: Border.all()),
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    bool result = await postLoginAPI(
                      usernameController.text,
                      passwordController.text,
                    );
                    print(result);
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text("Login")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
