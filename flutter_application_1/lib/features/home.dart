import 'package:flutter/material.dart ';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'The Venue Booking System is a modern digital platform designed to simplify the process of booking venues for social gatherings, corporate meetings, and special events. The application allows users to explore a wide range of venues based on their preferences such as location, price, and availability. With an intuitive interface and secure payment options, users can easily book venues while venue owners can manage their listings efficiently. The system aims to reduce manual booking efforts and provide a seamless experience for both clients and venue owners.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
