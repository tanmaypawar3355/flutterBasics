import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:image_picker/image_picker.dart';

class HomePage8 extends StatefulWidget {
  const HomePage8({super.key});

  @override
  State<HomePage8> createState() => _HomePage8State();
}

class _HomePage8State extends State<HomePage8> {
  //
  File? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      selectedImage = File(image.path);
    }
  }

  Future<bool> uploadImageAPI() async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    final multipartFile = await http.MultipartFile.fromPath(
      "file",
      selectedImage!.path,
    );

    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 201) {
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
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 300,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                selectImageFromGallery();
              },
              child: Container(
                height: 300,
                width: 300,
                child: selectedImage == null
                    ? Text("Select an image")
                    : Image.file(selectedImage!),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                if (selectedImage != null) {
                  bool result = await uploadImageAPI();

                  setState(() {
                    if (result) {
                      showMyAlertDialog("Image uploaded successfuly");
                    } else {
                      showMyAlertDialog("Image upload failed");
                    }
                  });
                } else {
                  setState(() {
                    showMyAlertDialog("Select an image first");
                  });
                }
              },
              child: Container(
                width: 300,
                height: 60,
                color: Colors.grey[300],
                child: Text("Upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
