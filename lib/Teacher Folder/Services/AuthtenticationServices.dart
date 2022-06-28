import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed Out!";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
