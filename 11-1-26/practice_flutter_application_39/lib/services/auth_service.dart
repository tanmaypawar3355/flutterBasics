import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
  }

  User? get user {
    return _user;
  }

  Future<bool> login(String email, password) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credentials.user != null) {
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, password) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credentials.user != null) {
      return true;
    }
    return false;
  }

  void logout() {
    _firebaseAuth.signOut();
  }

  void authStateChangesStreamListener(User? user) {
    _user = user;
  }
  
}
