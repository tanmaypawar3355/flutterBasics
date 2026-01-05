import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  MediaService() {}

  Future<File?> selecteImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
