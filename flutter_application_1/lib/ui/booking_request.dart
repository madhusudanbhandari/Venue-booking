import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/booking_service.dart';
import 'package:flutter_application_1/ui/booking_detail.dart';

class BookingRequestsPage extends StatelessWidget {
  const BookingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Booking Requests")),
      body: StreamBuilder(
        stream: BookingServices().getOwnerBookingRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!.docs;

          if (bookings.isEmpty) {
            return const Center(child: Text("No booking requests"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final data = bookings[index].data() as Map<String, dynamic>;
              final bookingId = bookings[index].id;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(data['clientName']),
                  subtitle: Text(
                    "${data['venueName']} • Rs ${data['totalAmount']}",
                  ),
                  trailing: Text(
                    data['status'].toString().toUpperCase(),
                    style: TextStyle(
                      color: data['status'] == 'approved'
                          ? Colors.green
                          : data['status'] == 'rejected'
                          ? Colors.red
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailPage(
                          bookingId: bookingId,
                          bookingData: data,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
