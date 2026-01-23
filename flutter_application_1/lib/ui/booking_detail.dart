import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/booking_service.dart';

class BookingDetailPage extends StatefulWidget {
  final String bookingId;
  final Map<String, dynamic> bookingData;

  const BookingDetailPage({
    super.key,
    required this.bookingId,
    required this.bookingData,
  });

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool _isLoading = false;

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = (timestamp as Timestamp).toDate();
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _updateStatus(String status) async {
    setState(() => _isLoading = true);

    try {
      await BookingServices().updateBookingStatus(widget.bookingId, status);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status == 'approved' ? "Booking Approved!" : "Booking Rejected",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.bookingData;
    final status = data['status'];

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status
                  Center(
                    child: Chip(
                      label: Text(
                        status.toString().toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: status == 'approved'
                          ? Colors.green.shade100
                          : status == 'rejected'
                          ? Colors.red.shade100
                          : Colors.orange.shade100,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Venue Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['venueName'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(data['venueLocation']),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Client Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Client: ${data['clientName']}"),
                          Text("Phone: ${data['clientPhone']}"),
                          Text("Email: ${data['clientEmail']}"),
                          Text("Guests: ${data['numberOfGuests']}"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Booking Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start: ${_formatDate(data['startDate'])}"),
                          Text("End: ${_formatDate(data['endDate'])}"),
                          Text("Payment: ${data['paymentMethod']}"),
                          const SizedBox(height: 8),
                          Text(
                            "Total: Rs ${data['totalAmount']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Buttons (only if pending)
                  if (status == 'pending')
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _updateStatus('rejected'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Text("REJECT"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _updateStatus('approved'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Text("APPROVE"),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
