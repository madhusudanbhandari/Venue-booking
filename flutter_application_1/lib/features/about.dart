import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: const Text('About Book-Garau'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'The Venue Booking System was developed to address the challenges '
                'of traditional venue booking methods, which often involve manual '
                'coordination, lack of transparency, and limited availability information.\n\n'
                'Our platform bridges the gap between venue owners and clients by '
                'providing a centralized digital solution. By leveraging modern '
                'technologies such as Flutter and Firebase, the system delivers a '
                'scalable, secure, and user-friendly experience that supports both '
                'individual and business event planning needs.',
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
