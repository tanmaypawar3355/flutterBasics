import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  MediaService();

  final ImagePicker _picker = ImagePicker();

  Future<File?> selectImage() async {
    final XFile? imageSelected = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imageSelected != null) {
      return File(imageSelected.path);
    }
    return null;
  }
}
