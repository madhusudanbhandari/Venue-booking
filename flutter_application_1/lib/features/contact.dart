import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
                'We value user feedback and are always ready to assist with any '
                'queries or issues you may have.\n\n'
                'The Contact section allows users to get in touch with our support '
                'team for booking assistance, technical issues, or general inquiries. '
                'Users can submit their name, email address, and message, and our '
                'team will respond promptly.\n\n'
                'This section ensures effective communication and enhances user '
                'trust, reliability, and overall satisfaction.',
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
