import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';

class BookingSuccessPage extends StatelessWidget {
  final DoctorModel doctor;
  final DateTime selectedDate;
  final String selectedSlot;
  final String paymentMethod;

  const BookingSuccessPage({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedSlot,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    final paymentStatus = paymentMethod == 'Pay Online' ? 'Completed' : 'Pending';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Booking Confirmed',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Appointment with Dr. ${doctor.personal['fullName']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$dateStr, $selectedSlot',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Method: $paymentMethod', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Payment Status: $paymentStatus', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Doctor Specialty: ${doctor.personal['department']}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}