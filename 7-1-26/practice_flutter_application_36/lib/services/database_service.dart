import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practice_flutter_application_36/models/user_profile.dart';

class DatabaseService {
  DatabaseService() {
    _uploadUserInfo();
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? _usersCollection;

  void _uploadUserInfo() {
    _usersCollection = _firebaseFirestore
        .collection("users")
        .withConverter<UserProfile>(
          fromFirestore: (snapshots, _) =>
              UserProfile.fromJson(snapshots.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );
  }

  void createUserProfile({required UserProfile userProfile}) async {
    await _usersCollection?.doc(userProfile.uid).set(userProfile);
  }
}
