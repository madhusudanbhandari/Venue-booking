import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VenueServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addVenue({
    required String name,
    required String location,
    required double price,
    required int capacity,
    required String description,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("Owner not logged in");
    }

    await _db.collection('venues').add({
      'ownerId': user.uid,
      'name': name,
      'location': location,
      'price': price,
      'capacity': capacity,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getOwnerVenues() {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    return _db
        .collection('venues')
        .where('ownerId', isEqualTo: user.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllVenues() {
    return _db
        .collection('venues')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  // Add to your BookingServices class
}
