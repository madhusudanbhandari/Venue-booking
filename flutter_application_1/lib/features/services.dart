import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: const Text('Home'),
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
                'Our platform offers a comprehensive set of services to make venue booking fast, reliable, and secure.\n\n'
                'Clients can search and filter venues based on location, pricing, capacity, and facilities. The system provides real-time availability, secure online payments, and instant booking confirmation.\n\n'
                'Venue owners can register their venues, upload images, manage pricing, and handle bookings through a dedicated dashboard.\n\n'
                'These services ensure transparency, convenience, and efficiency for all users while creating a seamless experience for both clients and venue owners.',
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
