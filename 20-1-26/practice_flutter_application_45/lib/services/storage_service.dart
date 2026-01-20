import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserPFP({
    required File file,
    required String uid,
  }) async {
    Reference _ref = _firebaseStorage
        .ref('users/pfps')
        .child('$uid${p.extension(file.path)}');

    TaskSnapshot task = await _ref.putFile(file);

    if (task.state == TaskState.success) {
      return _ref.getDownloadURL();
    }
    return null;
  }

  Future<String?> uploadChatImage({
    required File file,
    required String chatID,
  }) {
    // _firebaseStorage.ref("chats/$chatID").child(path)
  }
}
