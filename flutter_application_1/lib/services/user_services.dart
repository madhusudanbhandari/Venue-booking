import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ✅ SAVE USER DATA (SIGNUP)
  Future<void> saveUserData({
    required String name,
    required String email,
    required String role,
    required String phone,
    required String address,
  }) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw "No authenticated user found";
    }

    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ✅ GET USER ROLE (LOGIN)
  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw "No authenticated user found";
    }

    DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      throw "User data not found in Firestore";
    }

    return doc['role'];
  }
}
