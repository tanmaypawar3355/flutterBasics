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
    Reference ref = _firebaseStorage
        .ref("users/pfp")
        .child("$uid${p.extension(file.path)}");

    TaskSnapshot task = await ref.putFile(file);

    if (task.state == TaskState.success) {
      return ref.getDownloadURL();
    }
    return null;
  }
}
