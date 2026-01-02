import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangeStreamListerner);
  }

  User? _user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user {
    return _user;
  }

  Future<bool> logIn(String email, String password) async {
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

  Future<bool> registerNewUser(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  void authStateChangeStreamListerner(User? user) {
    _user = user;
  }
}
