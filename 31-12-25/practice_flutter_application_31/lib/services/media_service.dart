import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker selectedImage = ImagePicker();

  MediaService();

  Future<File?> imagePicker() async {
    final XFile? _file = await selectedImage.pickImage(
      source: ImageSource.gallery,
    );

    if (_file != null) {
      print("file");
      return File(_file.path);
    }
    return null;
  }
}
