import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage5> {
  //

  //
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 100),
        child: Column(
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
                print("pressed");
                String? accessToken;
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

                //////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////
                // if (accessToken != null) {
                print("in get");
                APIService().getAPI(accessToken!).then((value) {
                  var data = value;

                  print(data['id']);
                  print(data['email']);
                  print(data['password']);
                  print(data['name']);
                  print(data['role']);
                  print(data['avatar']);
                  print(data['creationAt']);
                  print(data['updatedAt']);
                });
                // } else {
                print("Byee");
                // }
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    "Login",
                    textScaleFactor: 2,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
