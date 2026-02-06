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
  final ImagePicker _imagePicker = ImagePicker();
  File? selectcedImage;

  Future<void> selectImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    print(image);

    if (image != null) {
      setState(() {
        selectcedImage = File(image.path);
      });
    }
  }

  Future<void> uploadImageAPI() async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    final multipartFile = await http.MultipartFile.fromPath("file", selectcedImage!.path);

    request.files.add(multipartFile);

    http.StreamedResponse isUploaded = await request.send();
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
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selectcedImage != null
                    ? Center(child: Image.file(selectcedImage!))
                    : Center(child: Text("Select an image")),
              ),
              Spacer(),

              Container(
                width: 200,
                height: 50,
                color: Colors.grey[300],
                child: Center(child: Text("Upload Image")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
