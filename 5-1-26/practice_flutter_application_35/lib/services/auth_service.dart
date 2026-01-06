import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangeListener);
  }

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
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
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
    }
    return false;
  }



  Future<void> logout() async {
     await _firebaseAuth.signOut();
  }

  void authStateChangeListener(User? user) {
    _user = user;
  }
}
