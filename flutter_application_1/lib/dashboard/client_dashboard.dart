import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/venue_services.dart';
import 'package:flutter_application_1/ui/profile_page.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client Dashboard"),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// 🔍 Search
            TextField(
              decoration: InputDecoration(
                hintText: "Search venues by location or name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🎯 Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Chip(label: Text("Price")),
                Chip(label: Text("Location")),
                Chip(label: Text("Capacity")),
              ],
            ),

            const SizedBox(height: 30),

            /// 🏛 Featured Venues
            const Text(
              "Available Venues",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            printVenues(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Widget _venueCard() {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 15),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: ListTile(
  //       // leading: const Icon(Icons.location_city),
  //       // title: const Text("Grand Hall"),
  //       // subtitle: const Text("Kathmandu • Rs. 20,000/day"),
  //       // trailing: ElevatedButton(onPressed: () {}, child: const Text("Book")),

  //     ),
  //   );
  // }
  printVenues() async {
    VenueServices venueServices = VenueServices();
    List<Map<String, dynamic>> venues = await venueServices.getAllVenues();

    for (var venue in venues) {
      print(
        "Name: ${venue['name']}, Location: ${venue['location']}, Price: ${venue['price']}",
      );
    }
  }
}
