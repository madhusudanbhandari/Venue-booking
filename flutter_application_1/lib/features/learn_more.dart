import 'package:flutter/material.dart ';

class LearnMore extends StatelessWidget {
  const LearnMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text('More about us'), centerTitle: true),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'The Venue Booking System is designed to simplify the entire process of finding, booking, and managing venues through a single digital platform. It eliminates the need for manual inquiries, phone calls, and physical visits by providing accurate venue information, availability, and pricing in real time.Clients can search for venues based on location, budget, capacity, and event type. The platform ensures transparency by displaying detailed venue descriptions, images, facilities, and user-friendly booking options. Secure online payment integration allows users to complete bookings confidently and receive instant confirmation.Venue owners benefit from a dedicated dashboard where they can register their venues, update details, manage pricing, and track bookings efficiently. The system helps owners reach a wider audience while maintaining full control over their venue listings.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
