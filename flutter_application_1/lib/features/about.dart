import 'package:flutter/material.dart ';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Book-Garau'), centerTitle: true),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'The Venue Booking System was developed to address the challenges of traditional venue booking methods, which often involve manual coordination, lack of transparency, and limited availability information. Our platform bridges the gap between venue owners and clients by providing a centralized digital solution. By leveraging modern technologies such as Flutter and Firebase, the system delivers a scalable, secure, and user-friendly experience that supports both individual and business event planning needs.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
