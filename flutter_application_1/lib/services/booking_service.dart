import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createBooking({
    required String venueId,
    required String venueName,
    required String venueLocation,
    required String clientName,
    required String clientPhone,
    required String clientEmail,
    required int numberOfGuests,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentMethod,
    required double totalAmount,
    required String notes,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("Client not logged in");
    }

    await _db.collection('bookings').add({
      'venueId': venueId,
      'venueName': venueName,
      'venueLocation': venueLocation,
      'clientId': user.uid,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'clientEmail': clientEmail,
      'numberOfGuests': numberOfGuests,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'notes': notes,
      'status': 'pending', // pending, approved, rejected
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getClientBookings() {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    return _db
        .collection('bookings')
        .where('clientId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getVenueBookings(String venueId) {
    return _db
        .collection('bookings')
        .where('venueId', isEqualTo: venueId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _db.collection('bookings').doc(bookingId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
