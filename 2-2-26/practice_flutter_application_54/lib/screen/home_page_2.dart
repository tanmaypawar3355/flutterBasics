import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  File? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  ///////////////////////////////////////////////////////
  void selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  ///////////////////////////////////////////////////////
  void uploadImageURL() async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("file", selectedImage!.path),
    );

    var response = await request.send();

    if (response.statusCode == 201) {
      print("Successfully uploaded");
    } else {
      print("Failed to upload");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 500,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImageFromGallery();
                },
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: selectedImage == null
                        ? Text(
                            "Select an image",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                ),
              ),
              Spacer(),

              GestureDetector(
                onTap: () {
                  uploadImageURL();
                },
                child: Container(
                  height: 50,
                  width: 300,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
