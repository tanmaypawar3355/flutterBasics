import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChnagesStreamListener);
  }

  User? _user;

  Future<bool> login(String email, String password) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credentials.user != null) {
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credentials.user != null) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get user {
    return _user;
  }

  void authStateChnagesStreamListener(User? user) {
    _user = user;
  }
}
