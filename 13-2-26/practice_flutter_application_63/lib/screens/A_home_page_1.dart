import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_flutter_application_63/API_service.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  File? selecteImage;
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? bytes;
  String? fileName;
  dynamic data;

  void selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      bytes = await image.readAsBytes();
      fileName = image.name;
      setState(() {
        selecteImage = File(image.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (selecteImage != null) {
      await ApiService()
          .uploadImageAPI(bytes!, fileName!)
          .then((value) {
            data = value;
          })
          .onError((error, stackTrace) {
            print(error);
          });
    }
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
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selecteImage == null
                    ? Center(child: Text("Select an image", textScaleFactor: 2))
                    : Image.file(selecteImage!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                await uploadImage();
                print(data);
              },
              child: Container(
                width: 300,
                height: 80,
                color: Colors.grey,
                child: Center(child: Text("Upload Image", textScaleFactor: 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
