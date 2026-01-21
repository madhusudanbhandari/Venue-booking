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

  Future<List<Map<String, dynamic>>> getAllVenues() async {
    QuerySnapshot snapshot = await _db.collection('venues').get();

    // Convert documents to a list of maps
    List<Map<String, dynamic>> venues = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // include the document ID if needed
      return data;
    }).toList();

    return venues;
  }

  // Stream<List<Map<String, dynamic>>> streamVenues() {
  //   return _db
  //       .collection('venues')
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs.map((doc) {
  //           Map<String, dynamic> data = doc.data();
  //           data['id'] = doc.id; // include document ID
  //           return data;
  //         }).toList(),
  //       );
  // }
}
