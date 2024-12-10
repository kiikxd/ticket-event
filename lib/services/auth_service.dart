import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the registered user
    } catch (e) {
      print("Error during registration: $e");
      return null; // Return null if registration fails
    }
  }

  // Sign-in user
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the signed-in user
    } catch (e) {
      print("Error during sign-in: $e");
      return null; // Return null if sign-in fails
    }
  }

  // Sign-out user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
