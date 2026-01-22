import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/booking_service.dart';

class BookVenuePage extends StatefulWidget {
  final String venueId;
  final String venueName;
  final dynamic venuePrice;
  final String venueLocation;

  const BookVenuePage({
    super.key,
    required this.venueId,
    required this.venueName,
    required this.venuePrice,
    required this.venueLocation,
  });

  @override
  State<BookVenuePage> createState() => _BookVenuePageState();
}

class _BookVenuePageState extends State<BookVenuePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _guestsCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  String _selectedPaymentMethod = 'Cash on Venue';
  bool _isLoading = false;

  final List<String> _paymentMethods = [
    'Cash on Venue',
    'eSewa',
    'Khalti',
    'Bank Transfer',
    'Credit/Debit Card',
  ];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked;
        } else {
          _selectedEndDate = picked;
        }
      });
    }
  }

  int _calculateDays() {
    if (_selectedStartDate == null || _selectedEndDate == null) return 0;
    return _selectedEndDate!.difference(_selectedStartDate!).inDays + 1;
  }

  double _calculateTotal() {
    final days = _calculateDays();
    final price = widget.venuePrice is int
        ? (widget.venuePrice as int).toDouble()
        : widget.venuePrice as double;
    return days * price;
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedStartDate == null || _selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both start and end dates")),
      );
      return;
    }

    if (_selectedEndDate!.isBefore(_selectedStartDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("End date must be after start date")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final bookingService = BookingServices();
      await bookingService.createBooking(
        venueId: widget.venueId,
        venueName: widget.venueName,
        venueLocation: widget.venueLocation,
        clientName: _nameCtrl.text.trim(),
        clientPhone: _phoneCtrl.text.trim(),
        clientEmail: _emailCtrl.text.trim(),
        numberOfGuests: int.parse(_guestsCtrl.text.trim()),
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        paymentMethod: _selectedPaymentMethod,
        totalAmount: _calculateTotal(),
        notes: _notesCtrl.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking request sent successfully!")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Venue"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Venue Details Card
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.venueName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.venueLocation),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rs ${widget.venuePrice}/day",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Personal Details Section
              const Text(
                "Personal Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildField(
                controller: _nameCtrl,
                label: "Full Name",
                icon: Icons.person,
              ),

              _buildField(
                controller: _phoneCtrl,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              _buildField(
                controller: _emailCtrl,
                label: "Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              /// Booking Details Section
              const Text(
                "Booking Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /// Start Date Picker
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Start Date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _selectedStartDate == null
                        ? "Select start date"
                        : "${_selectedStartDate!.day}/${_selectedStartDate!.month}/${_selectedStartDate!.year}",
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// End Date Picker
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "End Date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _selectedEndDate == null
                        ? "Select end date"
                        : "${_selectedEndDate!.day}/${_selectedEndDate!.month}/${_selectedEndDate!.year}",
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _buildField(
                controller: _guestsCtrl,
                label: "Number of Guests",
                icon: Icons.people,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              /// Payment Method Section
              const Text(
                "Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.payment),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem(value: method, child: Text(method));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              _buildField(
                controller: _notesCtrl,
                label: "Additional Notes (Optional)",
                icon: Icons.note,
                maxLines: 3,
                isRequired: false,
              ),

              const SizedBox(height: 24),

              /// Total Summary Card
              if (_selectedStartDate != null && _selectedEndDate != null)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Number of Days:"),
                            Text(
                              "${_calculateDays()} day(s)",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Amount:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rs ${_calculateTotal().toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitBooking,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "CONFIRM BOOKING",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: isRequired
            ? (value) =>
                  value == null || value.isEmpty ? "Required field" : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
