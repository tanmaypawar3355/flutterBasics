import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isNotReady = false;
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST API LOGIN"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
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
                  setState(() {
                    isNotReady = true;
                  });
                  String? accessToken;
                  await ApiService()
                      .postLoginAPI(
                        emailController.text,
                        passwordController.text,
                      )
                      .then((value) {
                        setState(() {
                          accessToken = value;
                          print(accessToken);
                        });
                      })
                      .onError((error, stackTrace) {
                        print(error.toString());
                      });

                  //////////////////////////////////////////
                  //////////////////////////////////////////

                  await ApiService()
                      .getLoginAPI(accessToken!)
                      .then((value) {
                        setState(() {
                          data = value;
                          print(data);
                        });
                      })
                      .onError((error, stackTrace) {
                        print(error.toString());
                      });

                  
                  setState(() {
                    isNotReady = false;
                  });
                },
                child: isNotReady
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        width: 300,
                        height: 50,
                        color: Colors.grey[300],
                        child: Center(
                          child: data != null
                              ? Text("Login Successful")
                              : Text("Login"),
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
