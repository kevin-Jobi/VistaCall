// lib/presentation/views/home/upcoming_appointment_card.dart
import 'package:flutter/material.dart';
import 'package:vistacall/utils/premium_theme.dart';

/// Static for now. Every value is a parameter so you can plug in your
/// Appointment model later (e.g. UpcomingAppointmentCard(doctorName: a.doctorName, ...)).
class UpcomingAppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String badge;
  final VoidCallback? onDetails;

  const UpcomingAppointmentCard({
    super.key,
    this.doctorName = 'Dr. Sophia Martin',
    this.specialty = 'Cardiologist',
    this.date = 'Thu, 12 Nov',
    this.time = '10:30 AM',
    this.badge = 'In 3 days',
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: PremiumColors.navyGradient,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
            color: PremiumColors.accent.withValues(alpha: 0.35), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: PremiumColors.navy800.withValues(alpha: 0.28),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'UPCOMING',
                style: TextStyle(
                  color: PremiumColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 11.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              PremiumAvatar(initials: premiumInitials(doctorName), size: 52),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      specialty,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 14),
          Row(
            children: [
              _MetaChip(icon: Icons.calendar_today_rounded, label: date),
              const SizedBox(width: 16),
              _MetaChip(icon: Icons.access_time_rounded, label: time),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onDetails,
                child: const Row(
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        color: PremiumColors.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.chevron_right_rounded,
                        color: PremiumColors.accent, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.65)),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9), fontSize: 12.5),
        ),
      ],
    );
  }
}