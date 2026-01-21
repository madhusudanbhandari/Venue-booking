import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/venue_services.dart';
import 'package:flutter_application_1/ui/add_venue_page.dart';
import 'package:flutter_application_1/ui/profile_page.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Dashboard"),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVenuePage()),
          );
        },
        child: const Text('Add Venue'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// 💰 Earnings
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.attach_money),
                title: Text("Total Earnings"),
                subtitle: Text("Rs. 1,20,000"),
              ),
            ),

            const SizedBox(height: 25),

            /// 🏛 My Venues
            const Text(
              "My Venues",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            //_venueTile(),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: VenueServices().getAllVenues(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No venues found");
                } else {
                  final venues = snapshot.data!;
                  return Column(
                    children: venues.map((venue) {
                      return Card(
                        child: ListTile(
                          title: Text(venue['name']),
                          subtitle: Text(venue['location']),
                          trailing: Text("Rs. ${venue['price']}"),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),

            const SizedBox(height: 30),

            /// 📅 Booking Requests
            const Text(
              "Booking Requests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _bookingRequest(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation based on index
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Bookings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Widget _venueTile() {
  //   return Card(
  //     child: ListTile(
  //       leading: const Icon(Icons.location_city),
  //       title: const Text("Grand Hall"),
  //       subtitle: const Text("Active"),
  //       trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
  //     ),
  //   );
  // }
  // Removed printVenues() as it's not needed anymore.

  Widget _bookingRequest() {
    return Card(
      child: ListTile(
        title: const Text("Booking from Ram"),
        subtitle: const Text("Date: 25 Oct • 1 Day"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
