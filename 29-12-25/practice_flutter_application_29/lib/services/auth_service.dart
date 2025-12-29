import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;

  AuthService();

  User? get user {
    return _user;
  }

  Future<bool> logIn(String email, String password) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credentials.user != null) {
      _user = credentials.user;
      return true;
    }
    return false;
  }
}
