import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_flutter_application_65/API_service.dart';

class HomePage6 extends StatefulWidget {
  const HomePage6({super.key});

  @override
  State<HomePage6> createState() => _HomePage6State();
}

class _HomePage6State extends State<HomePage6> {
  File? selectedImage;
  bool isSelected = false;
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? bytes;
  String? fileName;
  dynamic data;

  Future<void> selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      bytes = await image.readAsBytes();

      setState(() {
        fileName = image.name;
        selectedImage = File(image.path);
      });
    }
  }

  void uploadImage() async {
    await ApiService()
        .uploadImage(bytes!, fileName!)
        .then((value) {
          setState(() {
            data = value;
            print(data);
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST Image API"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                data = null;
                selectImageFromGallery();
              },
              child: Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selectedImage == null
                    ? Center(child: Text("Select an image"))
                    : data == null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : Center(child: Text("Image uploaded\nsuccessfully")),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (selectedImage != null) {
                  uploadImage();
                }
              },
              child: Container(
                width: 200,
                height: 50,
                child: Center(child: Text("Upload Image")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
