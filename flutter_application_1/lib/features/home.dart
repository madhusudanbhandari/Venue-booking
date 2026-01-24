import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                'The Venue Booking System is a modern digital platform designed to '
                'simplify the process of booking venues for social gatherings, '
                'corporate meetings, and special events.\n\n'
                'The application allows users to explore a wide range of venues '
                'based on preferences such as location, price, and availability. '
                'With an intuitive interface and secure payment options, users '
                'can easily book venues while venue owners manage their listings '
                'efficiently.\n\n'
                'The system aims to reduce manual booking efforts and provide a '
                'seamless, transparent, and reliable experience for both clients '
                'and venue owners.',
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
