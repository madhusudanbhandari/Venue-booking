import 'package:flutter/material.dart';

class LearnMore extends StatelessWidget {
  const LearnMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: const Text('How to Reach Us'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.blueAccent,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'The Venue Booking System is designed to simplify the entire process of finding, booking, and managing venues through a single digital platform.\n\n'
                'It eliminates the need for manual inquiries, phone calls, and physical visits by providing accurate venue information, availability, and pricing in real time.\n\n'
                'Clients can search for venues based on location, budget, capacity, and event type. The platform ensures transparency by displaying detailed venue descriptions, images, facilities, and user-friendly booking options.\n\n'
                'Secure online payment integration allows users to complete bookings confidently and receive instant confirmation.\n\n'
                'Venue owners benefit from a dedicated dashboard where they can register their venues, update details, manage pricing, and track bookings efficiently. The system helps owners reach a wider audience while maintaining full control over their venue listings.',
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
