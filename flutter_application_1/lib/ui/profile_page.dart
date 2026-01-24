import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user_services.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        elevation: 0,
      ),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Profile header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user['role'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Profile details card
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _profileItem(
                            icon: Icons.email,
                            label: "Email",
                            value: user['email'],
                          ),
                          _divider(),
                          _profileItem(
                            icon: Icons.phone,
                            label: "Phone",
                            value: user['phone'],
                          ),
                          _divider(),
                          _profileItem(
                            icon: Icons.home,
                            label: "Address",
                            value: user['address'],
                          ),
                          _divider(),
                          _profileItem(
                            icon: Icons.badge,
                            label: "Role",
                            value: user['role'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(color: Colors.grey.shade300),
    );
  }
}
