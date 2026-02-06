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

  bool isLoading = false;
  bool? result;

  Future<bool> postAPI(String username, password) async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      return true;
    }
    setState(() {
      isLoading = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: result != true
              ? Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        result = await postAPI(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                        setState(() {
                          
                        });
                        print(result);
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        color: Colors.grey[300],
                        child: Center(child: isLoading != false ? Center(child: CircularProgressIndicator()) : Text("Login")),
                      ),
                    ),
                  ],
                )
              : Center(child: Text("Woohoo Logged In")),
        ),
      ),
    );
  }
}
