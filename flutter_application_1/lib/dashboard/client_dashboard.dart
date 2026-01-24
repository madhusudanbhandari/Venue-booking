import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/venue_services.dart';
import 'package:flutter_application_1/ui/book_venue.dart';
import 'package:flutter_application_1/ui/profile_page.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All'; // All, Price, Location, Capacity

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter venues based on search query and selected filter
  List<dynamic> _filterVenues(List<dynamic> venues) {
    if (_searchQuery.isEmpty) {
      return venues;
    }

    return venues.where((venue) {
      final data = venue.data() as Map<String, dynamic>;
      final name = (data['name'] ?? '').toString().toLowerCase();
      final location = (data['location'] ?? '').toString().toLowerCase();
      final capacity = (data['capacity'] ?? '').toString().toLowerCase();
      final price = (data['price'] ?? '').toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      // Search based on selected filter
      switch (_selectedFilter) {
        case 'Price':
          return price.contains(query);
        case 'Location':
          return location.contains(query);
        case 'Capacity':
          return capacity.contains(query);
        default: // 'All'
          return name.contains(query) ||
              location.contains(query) ||
              capacity.contains(query) ||
              price.contains(query);
      }
    }).toList();
  }

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
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    "Search venues by ${_selectedFilter == 'All' ? 'name, location, capacity, or price' : _selectedFilter.toLowerCase()}",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🎯 Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Price'),
                _buildFilterChip('Location'),
                _buildFilterChip('Capacity'),
              ],
            ),

            const SizedBox(height: 30),

            /// 🏛 Featured Venues
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Available Venues",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (_searchQuery.isNotEmpty)
                  StreamBuilder(
                    stream: VenueServices().getAllVenues(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();
                      final filtered = _filterVenues(snapshot.data!.docs);
                      return Text(
                        "${filtered.length} found",
                        style: const TextStyle(color: Colors.grey),
                      );
                    },
                  ),
              ],
            ),

            const SizedBox(height: 15),

            StreamBuilder(
              stream: VenueServices().getAllVenues(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final venues = snapshot.data!.docs;

                if (venues.isEmpty) {
                  return const Center(child: Text("No venues available"));
                }

                // Apply filters
                final filteredVenues = _filterVenues(venues);

                if (filteredVenues.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No venues found for '$_searchQuery'",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredVenues.length,
                  itemBuilder: (context, index) {
                    final data =
                        filteredVenues[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Venue name
                            Text(
                              data['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Location and capacity
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data['location'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.people,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Capacity ${data['capacity']}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Price and Book button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rs ${data['price']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookVenuePage(
                                          venueId: filteredVenues[index].id,
                                          venueName: data['name'],
                                          venuePrice: data['price'],
                                          venueLocation: data['location'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Book Now'),
                                ),
                              ],
                            ),
                          ],
                        ),
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
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: Colors.blue.shade200,
      checkmarkColor: Colors.blue.shade700,
    );
  }
}
