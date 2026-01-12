import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageService();

  Future<String?> uploadUserPFP({
    required File file,
    required String uid,
  }) async {
    Reference _ref = await _firebaseStorage
        .ref("users")
        .child("$uid${p.extension(file.path)}");

    TaskSnapshot task = await _ref.putFile(file);

    if (task.state == TaskState.success) {
      return _ref.getDownloadURL();
    }
    return null;
  }

  Future<String?> ulploadImageToChat({
    required File file,
    required String chatID,
  }) async {
    Reference ref = await _firebaseStorage
        .ref("chats/$chatID")
        .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');

    TaskSnapshot task = await ref.putFile(file);

    if (task.state == TaskState.success) {
      return ref.getDownloadURL();
    }
  }
}
