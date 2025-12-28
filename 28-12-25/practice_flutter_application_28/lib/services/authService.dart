import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Authservice() {}

  User? _user;

  User? get user {
    return _user;
  }

  Future<bool> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        _user = credentials.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
