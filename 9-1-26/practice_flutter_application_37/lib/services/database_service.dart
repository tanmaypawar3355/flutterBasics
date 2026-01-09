import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_37/models/user_profile.dart';
import 'package:practice_flutter_application_37/services/auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _setUpCollectionReferences();
    _authService = _getIt.get<AuthService>();
  }

  void _setUpCollectionReferences() {
    try {
      _userCollection = _firebaseFirestore
          .collection("users")
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

  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return _userCollection
            ?.where("uid", isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }
}
