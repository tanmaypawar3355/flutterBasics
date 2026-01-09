import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _image = ImagePicker();
  MediaService();

  Future<File?> selectImage() async {
    XFile? pickedImage = await _image.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
