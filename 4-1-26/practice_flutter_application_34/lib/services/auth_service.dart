import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChnagesListen);
  }

  User? _user;

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
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

  Future<bool> signUp(String email, password) async {
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

  void authStateChnagesListen(User? user) {
    _user = user;
  }

  User? get user {
    return _user;
  }
}
