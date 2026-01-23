import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/venue_services.dart';
import 'package:flutter_application_1/ui/add_venue_page.dart';
import 'package:flutter_application_1/ui/booking_detail.dart';
import 'package:flutter_application_1/services/booking_service.dart';
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVenuePage()),
          );
        },
        child: const Text('Add Venue', style: TextStyle(fontSize: 14)),
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
            StreamBuilder(
              stream: VenueServices().getOwnerVenues(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final venues = snapshot.data!.docs;

                if (venues.isEmpty) {
                  return const Center(child: Text("No venues added yet"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: venues.length,
                  itemBuilder: (context, index) {
                    final data = venues[index].data() as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['location']),
                        trailing: Text("Rs ${data['price']}"),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 30),

            /// 📅 Booking Requests
            const Text(
              "Booking Requests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            StreamBuilder(
              stream: BookingServices().getOwnerBookingRequests(),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // Check loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Check if data exists
                if (!snapshot.hasData) {
                  return const Center(child: Text("No data available"));
                }

                final bookings = snapshot.data!.docs;

                if (bookings.isEmpty) {
                  return const Center(child: Text("No booking requests"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final data = bookings[index].data() as Map<String, dynamic>;
                    final bookingId = bookings[index].id;

                    return Card(
                      child: ListTile(
                        title: Text(data['clientName'] ?? 'Unknown'),
                        subtitle: Text(
                          "${data['venueName'] ?? 'N/A'} • Rs ${data['totalAmount'] ?? 0}",
                        ),
                        trailing: Text(
                          (data['status'] ?? 'pending')
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                            color: data['status'] == 'approved'
                                ? Colors.green
                                : data['status'] == 'rejected'
                                ? Colors.red
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetailPage(
                                bookingId: bookingId,
                                bookingData: data,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
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
}
