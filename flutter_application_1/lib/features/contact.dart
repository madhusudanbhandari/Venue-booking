import 'package:flutter/material.dart ';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text('How to reach us?'), centerTitle: true),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'We value user feedback and are always ready to assist with any queries or issues. The Contact section allows users to get in touch with our support team for booking assistance, technical issues, or general inquiries. Users can submit their name, email address, and message, and our team will respond promptly. This section ensures effective communication and enhances user trust and satisfaction.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
