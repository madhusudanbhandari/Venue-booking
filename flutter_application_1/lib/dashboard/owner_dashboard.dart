import 'package:flutter/material.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Owner Dashboard')),
      body: const Center(
        child: Text('Welcome Venue Owner', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
