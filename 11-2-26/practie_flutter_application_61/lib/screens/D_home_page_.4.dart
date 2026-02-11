import 'package:flutter/material.dart';
import 'package:practie_flutter_application_61/apiServices/API_service.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  dynamic data;
  bool isReady = false;
  void _getMultiplePost() {
    isReady = true;
    ApiService()
        .multipleObjectWithoutModel()
        .then((value) {
          print(data.length);
          data = value;
          isReady = false;
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    
                  ),
                );
              },
            ),
    );
  }
}
