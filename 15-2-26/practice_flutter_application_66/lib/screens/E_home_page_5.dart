import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';

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
      appBar: AppBar(
        title: Text("POST API LOGIN"),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: Column(
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
                  String? accessToken;
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    await ApiService()
                        .postAPI(emailController.text, passwordController.text)
                        .then((value) {
                          accessToken = value!;
                          print(accessToken);
                        })
                        .onError((error, stackTrace) {
                          print(error.toString());
                        });
                  }

                  if (accessToken != null) {
                    await ApiService().getAPI(accessToken!).then((value) {
                      dynamic data = value;
                      print(data);
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.grey,
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
