import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST API"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
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
                  String? accessToken;
                  await ApiService()
                      .postAPI(emailController.text, passwordController.text)
                      .then((value) {
                        setState(() {
                          accessToken = value!;
                          print(accessToken);
                        });
                      });

                  if (accessToken != null) {
                    dynamic data;
                    ApiService().getAPI(accessToken!).then((value) {
                      setState(() {
                        data = value;
                        print(data['id']);
                        print(data['email']);
                        print(data['password']);
                        print(data['name']);
                        print(data['role']);
                        print(data['creationAt']);
                        print(data['updatedAt']);
                      });
                    });
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
