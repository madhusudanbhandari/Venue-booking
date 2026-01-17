import 'package:flutter/material.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Dashboard'), centerTitle: true),
      body: const Center(
        child: Text('Welcome Client', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
