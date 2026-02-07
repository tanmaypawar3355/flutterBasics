import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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

  Future<bool> uploadImageAPI() async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse('https://api.escuelajs.co/api/v1/files/upload'),
    );

    final multipartFile = await http.MultipartFile.fromPath(
      "file",
      selectedImage!.path,
    );

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                selectImageFromGallery();
              },
              child: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selectedImage == null
                    ? Center(child: Text("Select an imge"))
                    : Center(child: Image.file(selectedImage!)),
              ),
            ),

            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                bool result = await uploadImageAPI();
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.grey[300],
                child: Center(child: Text("Upload Image")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
