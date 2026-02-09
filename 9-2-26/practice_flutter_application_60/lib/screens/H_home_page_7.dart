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

  Future<bool> PostLoginAPI(String username, password) async {
    http.Response response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  void showMyAlertDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 300,
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              Spacer(),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Passord",
                  border: OutlineInputBorder(),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  bool result = await PostLoginAPI(
                    usernameController.text,
                    passwordController.text,
                  );
                  print(result);

                  setState(() {
                    if (result == true)
                      showMyAlertDialog("Login Successful");
                    else
                      showMyAlertDialog("Invalid Username or Password");
                  });
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
