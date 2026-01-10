import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_flutter_application_38/models/user_profile.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/services/auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  DatabaseService() {
    _setUpCollectionReference();
    _authService = _getIt.get<AuthService>();
  }

  void _setUpCollectionReference() {
    _userCollection = _firebaseFirestore
        .collection("user")
        .withConverter<UserProfile>(
          fromFirestore: (snapshots, _) =>
              UserProfile.fromJson(snapshots.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    await _userCollection!.doc(userProfile.uid).set(userProfile);
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    return _userCollection
            !.where("uid", isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }
}
