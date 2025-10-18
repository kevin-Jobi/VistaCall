// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:vistacall/data/models/appointment.dart';
// import 'package:vistacall/utils/constants.dart';

// class BookingDetailsPage extends StatefulWidget {
//   final Appointment appointment;

//   const BookingDetailsPage({
//     super.key,
//     required this.appointment,
//   });

//   @override
//   State<BookingDetailsPage> createState() => _BookingDetailsPageState();
// }

// class _BookingDetailsPageState extends State<BookingDetailsPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   // String? _paymentMethod;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _scaleAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.elasticOut,
//     );

//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );

//     _controller.forward();
//     // _fetchPaymentMethod();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateStr = _formatDate(widget.appointment.date);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     _buildSuccessIcon(),
//                     const SizedBox(height: 32),
//                     _buildSuccessMessage(),
//                     const SizedBox(height: 24),
//                     _buildAppointmentCard(dateStr),
//                     const SizedBox(height: 16),
//                     _buildDetailsCard(),
//                     const SizedBox(height: 24), // No action buttons
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Text(
//             'Booking Details',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1A1A1A),
//               letterSpacing: 0.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuccessIcon() {
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: Container(
//         width: 120,
//         height: 120,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF4CAF50).withOpacity(0.4),
//               blurRadius: 30,
//               offset: const Offset(0, 10),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 20,
//               right: 20,
//               child: Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.4),
//                       Colors.white.withOpacity(0.0),
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             const Center(
//               child: Icon(
//                 Icons.check_rounded,
//                 color: Colors.white,
//                 size: 64,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSuccessMessage() {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Column(
//         children: [
//           const Text(
//             'Booking Details',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.w800,
//               color: Color(0xFF1A1A1A),
//               letterSpacing: 0.3,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'View the details of your appointment',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//               letterSpacing: 0.2,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppointmentCard(String dateStr) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppConstants.primaryColor,
//             AppConstants.primaryColor.withOpacity(0.85),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: const Icon(
//                   Icons.person_rounded,
//                   color: Colors.white,
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Dr. ${widget.appointment.doctorName}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.appointment.specialty,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white.withOpacity(0.9),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: _buildInfoItem(
//                     Icons.calendar_today_rounded,
//                     'Date',
//                     dateStr,
//                   ),
//                 ),
//                 Container(
//                   width: 1,
//                   height: 40,
//                   color: Colors.white.withOpacity(0.3),
//                 ),
//                 Expanded(
//                   child: _buildInfoItem(
//                     Icons.access_time_rounded,
//                     'Time',
//                     widget.appointment.time,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem(IconData icon, String label, String value) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 20),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: Colors.white.withOpacity(0.8),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailsCard() {
//     final statusColor = widget.appointment.status == 'Completed'
//         ? const Color(0xFF4CAF50)
//         : const Color(0xFFFF9800);

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           _buildDetailRow(
//             Icons.person_outline,
//             'Patient Name',
//             widget.appointment.patientName,
//             AppConstants.primaryColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(
//       IconData icon, String label, String value, Color color) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: color, size: 22),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF1A1A1A),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd MMM yyyy').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vistacall/data/models/appointment.dart';

class BookingDetailsPage extends StatefulWidget {
  final Appointment appointment;

  const BookingDetailsPage({
    super.key,
    required this.appointment,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateStr = _formatDate(widget.appointment.date);

    
    final whiteBackground = colorScheme.surface; // Dynamic white surface

    return Scaffold(
      backgroundColor: whiteBackground, // Dynamic background
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, theme, colorScheme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildSuccessIcon(colorScheme),
                    const SizedBox(height: 32),
                    _buildSuccessMessage(theme, colorScheme),
                    const SizedBox(height: 24),
                    _buildAppointmentCard(context, theme, colorScheme, dateStr),
                    const SizedBox(height: 16),
                    _buildDetailsCard(context, theme, colorScheme),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final onSurfaceVariant = colorScheme.onSurfaceVariant ?? Colors.grey.shade700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface, // Dynamic white surface
      
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withValues(alpha: 0.1), // Dynamic light grey
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
              color: onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Booking Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon(ColorScheme colorScheme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF4CAF50), Color(0xFF81C784),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorScheme.tertiary.withValues(alpha: 0.4), // Dynamic shadow
              blurRadius: 30,
              offset: const Offset(0, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.4),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(ThemeData theme, ColorScheme colorScheme) {
    final onSurfaceVariant = colorScheme.onSurfaceVariant ?? Colors.grey.shade600;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Text(
            'Booking Details',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'View the details of your appointment',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: onSurfaceVariant,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context, 
    ThemeData theme, 
    ColorScheme colorScheme, 
    String dateStr
  ) {
    final onPrimary = colorScheme.onPrimary;
    final shadowColor = colorScheme.primary.withValues(alpha: 0.3);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary, // Dynamic primary
            colorScheme.primary.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor, // Dynamic primary shadow
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: onPrimary.withValues(alpha: 0.2), // Dynamic white overlay
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: onPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${widget.appointment.doctorName}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: onPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.appointment.specialty,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: onPrimary.withValues(alpha: 0.15), // Dynamic white overlay
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: onPrimary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.calendar_today_rounded,
                    'Date',
                    dateStr,
                    onPrimary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: onPrimary.withValues(alpha: 0.3),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.access_time_rounded,
                    'Time',
                    widget.appointment.time,
                    onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, Color textColor) {
    return Column(
      children: [
        Icon(icon, color: textColor, size: 20),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailsCard(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final shadowColor = theme.shadowColor;
    final statusColor = widget.appointment.status == 'Completed'
        ? colorScheme.tertiary // Dynamic success color
        : colorScheme.secondary; // Dynamic warning color

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface, // Dynamic white surface
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.2), // Dynamic shadow
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            Icons.person_outline,
            'Patient Name',
            widget.appointment.patientName,
            colorScheme.primary, // Dynamic primary for icon
            theme,
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon, 
    String label, 
    String value, 
    Color iconColor,
    ThemeData theme,
    ColorScheme colorScheme
  ) {
    final onSurfaceVariant = colorScheme.onSurfaceVariant ?? Colors.grey.shade600;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1), // Dynamic icon background
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}