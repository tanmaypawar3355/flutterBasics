import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomePage8 extends StatefulWidget {
  const HomePage8({super.key});

  @override
  State<HomePage8> createState() => _HomePage8State();
}

class _HomePage8State extends State<HomePage8> {
  File? selectedImage;
  bool isSelected = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    void selectImageFromGallery() async {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage = File(image.path);
      }
    }

    Future<void> postImageURI() async {
      final request = await http.MultipartRequest(
        "POST",
        Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
      );

      request.files.add(
        await http.MultipartFile.fromPath("file", selectedImage!.path),
      );

      final response = await request.send();

      if (response.statusCode == 201) {
        print("Uploaded successfully");
      } else {
        print("Failed to upload");
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (selectedImage == null) {
                  setState(() {});
                } else {
                  selectImageFromGallery();
                }
              },
              child: Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selectedImage == null
                    ? Text(isSelected == true ? "Select an image" : "")
                    : Text("First select an\nimage"),
              ),
            ),

            const SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                if (selectedImage == null) {
                  setState(() {
                    isSelected = false;
                  });
                }
                postImageURI();
              },
              child: Container(
                width: 200,
                height: 60,
                child: Text("Upload Image"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
