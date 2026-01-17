import 'package:flutter/material.dart ';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services we provide'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Our platform offers a comprehensive set of services to make venue booking fast, reliable, and secure. Clients can search and filter venues based on location, pricing, capacity, and facilities. The system provides real-time availability, secure online payments, and instant booking confirmation. Venue owners can register their venues, upload images, manage pricing, and handle bookings through a dedicated dashboard. These services ensure transparency, convenience, and efficiency for all users.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
