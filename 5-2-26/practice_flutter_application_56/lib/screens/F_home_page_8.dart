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
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
      selectedImage = File(image.path);
        
      });
    }
  }

  Future<void> postImageURL() async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("file", selectedImage!.path),
    );

    final response = await request.send();

    if (response.statusCode == 201) {
      print("Hiiiiiiiii");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImageFromGallery();
                },
                child: Container(
                  width: 300,
                  height: 400,
                  child: selectedImage == null
                      ? Text("Select an image")
                      : Image.file(selectedImage!),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  postImageURL();
                },
                child: Container(
                  height: 50,
                  width: 300,
                  color: Colors.grey[300],
                  child: Center(child: Text("Upload Image")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
