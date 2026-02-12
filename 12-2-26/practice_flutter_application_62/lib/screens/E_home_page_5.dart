import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  String? accessToken;
                  var data;

                  await APIService()
                      .postAPI(
                        emailController.text.toString(),
                        passwordController.text.toString(),
                      )
                      .then((value) {
                        setState(() {
                          accessToken = value;
                          print(accessToken);
                        });
                      })
                      .onError((error, stackTrace) {
                        print(error);
                      });

                  ////////////////////
                  if (accessToken != null) {
                    APIService()
                        .getAPI(accessToken!)
                        .then((value) {
                          setState(() {
                            data = value;
                          });
                          print(data['id']);
                          print(data['email']);
                          print(data['password']);
                          print(data['name']);
                          print(data['role']);
                          print(data['avatar']);
                        })
                        .onError((error, stackTrace) {
                          print(error);
                        });
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
