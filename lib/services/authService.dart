import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user
  Future<User?> registerWithEmailPassword(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Combine first name and last name into one username
      String username = '$firstName $lastName';

      // After user is created, save username to Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,  // Save the combined username in Firestore
          'email': email,        // Optionally save email
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

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
