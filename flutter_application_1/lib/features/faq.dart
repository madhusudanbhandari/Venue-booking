import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(title: const Text('FAQ'), centerTitle: true, elevation: 0),
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
                'The FAQ section provides clear answers to commonly asked questions '
                'regarding venue booking, payments, cancellations, and account management.\n\n'
                'It helps users understand how the system works without needing direct support. '
                'By addressing frequent concerns in a structured manner, the FAQ section improves '
                'user experience and reduces confusion.\n\n'
                'This makes the platform more accessible, reliable, and user-friendly for '
                'first-time users and regular customers alike.',
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
