import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Memuat data pengguna
  Future<Map<String, dynamic>> loadUserData() async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) throw Exception("User data not found");

    return doc.data() as Map<String, dynamic>;
  }

  // Memperbarui data pengguna
  Future<void> updateUserData({required String username, required String email}) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _firestore.collection('users').doc(user.uid).update({
      'username': username,
      'email': email,
    });
  }

  // Menghapus akun pengguna
  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _firestore.collection('users').doc(user.uid).delete();
    await user.delete();
  }
}
