import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;
  late Authservice _authservice;

  User? get user {
    return _user;
  }

  Authservice() {
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
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

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void authStateChangesStreamListener(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }
}
