import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> login(String email, password) async {
    setState(() {
      _isLoading = true;
    });
    Response response = await post(
      Uri.parse("https://dummyjson.com/user/login"),
      body: {"username": email, "password": password},
    );

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("Failed");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: _isLoading == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: emailController,
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
                        await login(
                          emailController.text.trim().toString(),
                          passwordController.text.trim().toString(),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        color: Colors.grey[300],
                        child: Center(child: Text("Login")),
                      ),
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
