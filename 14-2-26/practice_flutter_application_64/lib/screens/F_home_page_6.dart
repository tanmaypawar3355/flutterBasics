import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage6 extends StatefulWidget {
  const HomePage6({super.key});

  @override
  State<HomePage6> createState() => _HomePage6State();
}

class _HomePage6State extends State<HomePage6> {
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;
  String? fileName;
  late Uint8List bytes;

  void selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      bytes = await selectedImage!.readAsBytes();
      setState(() {
        fileName = image.name;
        selectedImage = File(image.path);
      });
    }
  }

  void uploadImage() async {
    await ApiService().uploadImageAPI(bytes, fileName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Upi"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                selectImageFromGallery();
              },
              child: Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.lightBlue,
                child: Center(child: Text("Upload Image")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
