import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> userPfp({required File file, required String uid}) async {
    Reference ref = _firebaseStorage
        .ref("users/pfp")
        .child("$uid${p.extension(file.path)}");

    UploadTask task = ref.putFile(file);

    return task.then((p) {
      if (p.state == TaskState.success) {
        return ref.getDownloadURL();
      }
      return null;
    });
  }
}
