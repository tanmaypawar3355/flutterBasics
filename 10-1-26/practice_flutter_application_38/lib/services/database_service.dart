import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/models/user_profile.dart';
import 'package:practice_flutter_application_38/services/auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  DatabaseService() {
    _authService = _getIt.get<AuthService>();
    _setupUsersCollection();
  }

  void _setupUsersCollection() {
    try {
      _userCollection = _firebaseFirestore
          .collection("user")
          .withConverter<UserProfile>(
            fromFirestore: (snapshots, _) =>
                UserProfile.fromJson(snapshots.data()!),
            toFirestore: (userProfile, _) => userProfile.toJson(),
          );
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    try {
      await _userCollection?.doc(userProfile.uid).set(userProfile);
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    return _userCollection
            ?.where("user", isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }
}
