import 'package:flutter/material.dart';

class BookVenue extends StatefulWidget {
  const BookVenue({super.key});

  @override
  State<BookVenue> createState() => _BookVenueState();
}

class _BookVenueState extends State<BookVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Booking')),
      body: TextField(),
    );
  }
}
