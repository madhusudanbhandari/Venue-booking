import 'package:flutter/material.dart ';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text('FAQ'), centerTitle: true),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'The FAQ section provides clear answers to commonly asked questions regarding venue booking, payments, cancellations, and account management. It helps users understand how the system works without needing direct support. By addressing frequent concerns in a structured manner, the FAQ section improves user experience and reduces confusion, making the platform more accessible for first-time users.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
