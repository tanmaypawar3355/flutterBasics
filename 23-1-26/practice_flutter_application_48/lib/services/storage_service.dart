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
    Reference ref = _firebaseStorage
        .ref('users/pfps')
        .child('$uid${p.extension(file.path)}');

    TaskSnapshot task = await ref.putFile(file);

    if (task.state == TaskState.success) {
      return ref.getDownloadURL();
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<String?> uploadChatImage({
    required File file,
    required String chatID,
  }) async {
    Reference ref = _firebaseStorage
        .ref('chats/$chatID')
        .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');

    TaskSnapshot task = await ref.putFile(file);

    if (task.state == TaskState.success) {
      return ref.getDownloadURL();
    }
    return null;
  }
  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<String?> uploadStatusImage({
    required File file,
    required String uid,
  }) async {
    Reference ref = _firebaseStorage
        .ref('status/$uid')
        .child('$uid${p.extension(file.path)}');

    TaskSnapshot task = await ref.putFile(file);

    if (task.state == TaskState.success) {
      return ref.getDownloadURL();
    }
    return null;
  }
}
