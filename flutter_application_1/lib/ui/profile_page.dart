import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user_services.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userServices.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No profile data found"));
          }

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileItem("Name", user['name']),
                _profileItem("Email", user['email']),
                _profileItem("Phone", user['phone']),
                _profileItem("Address", user['address']),
                _profileItem("Role", user['role']),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
