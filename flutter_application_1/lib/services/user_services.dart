import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ==============================
  /// SAVE USER DATA AFTER SIGNUP
  /// ==============================
  Future<void> saveUserData({
    required String name,
    required String email,
    required String role,
    required String phone,
    required String address,
  }) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// ==============================
  /// GET USER ROLE (AFTER LOGIN)
  /// ==============================
  Future<String?> getUserRole() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    final DocumentSnapshot doc = await _db
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return doc.get('role');
  }

  /// ==============================
  /// GET COMPLETE USER DATA
  /// (FOR PROFILE PAGE)
  /// ==============================
  Future<Map<String, dynamic>?> getUserData() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    final DocumentSnapshot doc = await _db
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return doc.data() as Map<String, dynamic>;
  }

  /// ==============================
  /// UPDATE USER PROFILE
  /// ==============================
  Future<void> updateUserData({
    required String name,
    required String phone,
    required String address,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('users').doc(user.uid).update({
      'name': name,
      'phone': phone,
      'address': address,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
