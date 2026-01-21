import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  MediaService();

  Future<File?> selectImageFromGallery() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}
