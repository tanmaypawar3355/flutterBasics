import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  StorageService();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadUserPfp({
    required File file,
    required String uid,
  }) async {
    Reference _userRef = await _firebaseStorage
        .ref("users/pfp")
        .child("$uid${p.extension(file.path)}");

    UploadTask task = _userRef.putFile(file);

    if (task.snapshot == TaskState.success) {
      return _userRef.getDownloadURL();
    }
  }
}
