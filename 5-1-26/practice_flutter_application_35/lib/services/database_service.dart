import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_flutter_application_35/models/user_profile.dart';

class DatabaseService {
  DatabaseService() {
    _setUpCollectionReferences();
  }

  CollectionReference? _userCollection;

  final FirebaseFirestore _firebaseCollection = FirebaseFirestore.instance;

  void _setUpCollectionReferences() {
    try {
      _userCollection = _firebaseCollection
          .collection("users")
          .withConverter<UserProfile>(
            fromFirestore: (snapshots, _) =>
                UserProfile.fromJson(snapshots.data()!),
            toFirestore: (userProfile, _) => userProfile.toJson(),
          );
    } catch (e) {
      print("Error while creating collection");
    }
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    try {
      await _userCollection?.doc(userProfile.uid).set(userProfile);
    } catch (e) {
      print("Ith alay exception");
      print(e);
    }
  }
}
