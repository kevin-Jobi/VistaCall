// import 'package:flutter/material.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:vistacall/presentation/widgets/home/price_range_dialog.dart';
// import 'package:vistacall/utils/constants.dart';

// class SearchSection extends StatelessWidget {
//   final Function(String)? onSearchChanged;
//   const SearchSection({super.key, required this.onSearchChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'FIND YOUR DOCTOR',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: AppConstants.primaryColor,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             SizedBox(
//               width: 275,
//               child: CustomTextField(
//                 hintText: 'Search doctors, specialties...',
//                 prefixIcon: Icons.search,
//                 onChanged: onSearchChanged,
//               ),
//             ),
//             const SizedBox(
//               width: 1,
//             ),
//             IconButton(
//                 icon: const Icon(
//                   Icons.filter_list,
//                   size: 36,
//                 ),
//                 onPressed: () {
//                   showPriceRangeDialog(context);
//                 })
//           ],
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:vistacall/presentation/widgets/home/price_range_dialog.dart';
// import 'package:vistacall/utils/constants.dart';

// class SearchSection extends StatelessWidget {
//   final Function(String)? onSearchChanged;

//   const SearchSection({super.key, required this.onSearchChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             'FIND YOUR DOCTOR',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               color: AppConstants.primaryColor,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               Expanded(child: _buildSearchField()),
//               const SizedBox(width: 12),
//               _buildFilterButton(context),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchField() {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(28),
//         border: Border.all(
//           color: Colors.grey[300]!,
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         onChanged: onSearchChanged,
//         decoration: InputDecoration(
//           hintText: 'Search doctors, specialties...',
//           hintStyle: TextStyle(
//             color: Colors.grey[500],
//             fontSize: 15,
//           ),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Colors.grey[600],
//             size: 24,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//         style: const TextStyle(
//           fontSize: 15,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterButton(BuildContext context) {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.grey[300]!,
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: IconButton(
//         icon: Icon(
//           Icons.tune,
//           color: Colors.grey[700],
//           size: 24,
//         ),
//         onPressed: () {
//           showPriceRangeDialog(context);
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:vistacall/presentation/widgets/home/price_range_dialog.dart';
// import 'package:vistacall/utils/constants.dart';

// class SearchSection extends StatelessWidget {
//   final Function(String)? onSearchChanged;

//   const SearchSection({super.key, required this.onSearchChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               Container(
//                 width: 4,
//                 height: 28,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'FIND YOUR DOCTOR',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w800,
//                   color: AppConstants.primaryColor,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 18),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               Expanded(child: _buildSearchField()),
//               const SizedBox(width: 14),
//               _buildFilterButton(context),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchField() {
//     return Container(
//       height: 58,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.white,
//             Colors.grey[50]!,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(
//           color: Colors.grey[200]!,
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.08),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//             spreadRadius: 0,
//           ),
//           BoxShadow(
//             color: Colors.white.withOpacity(0.9),
//             blurRadius: 8,
//             offset: const Offset(-2, -2),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: TextField(
//         onChanged: onSearchChanged,
//         decoration: InputDecoration(
//           hintText: 'Search doctors, specialties...',
//           hintStyle: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//           ),
//           prefixIcon: Container(
//             padding: const EdgeInsets.all(12),
//             child: Icon(
//               Icons.search_rounded,
//               color: AppConstants.primaryColor,
//               size: 26,
//             ),
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 18,
//           ),
//         ),
//         style: const TextStyle(
//           fontSize: 15,
//           color: Color(0xFF1A1A1A),
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterButton(BuildContext context) {
//     return Container(
//       width: 58,
//       height: 58,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppConstants.primaryColor,
//             AppConstants.primaryColor.withOpacity(0.85),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.4),
//             blurRadius: 16,
//             offset: const Offset(0, 6),
//             spreadRadius: 0,
//           ),
//           BoxShadow(
//             color: Colors.white.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(-2, -2),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Shine effect
//           Positioned(
//             top: 6,
//             right: 6,
//             child: Container(
//               width: 18,
//               height: 18,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withOpacity(0.5),
//                     Colors.white.withOpacity(0.0),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(9),
//               ),
//             ),
//           ),
//           Center(
//             child: IconButton(
//               icon: const Icon(
//                 Icons.tune_rounded,
//                 color: Colors.white,
//                 size: 26,
//               ),
//               onPressed: () {
//                 showPriceRangeDialog(context);
//               },
//               padding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/home/price_range_dialog.dart';
import 'package:vistacall/utils/constants.dart';

class SearchSection extends StatelessWidget {
  final Function(String)? onSearchChanged;

  const SearchSection({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 28,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'FIND YOUR DOCTOR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppConstants.primaryColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(child: _buildSearchField()),
              const SizedBox(width: 14),
              _buildFilterButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: const Color(0xFFE3F2FD),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0xFF42A5F5).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants.primaryColor.withOpacity(0.15),
                  AppConstants.primaryColor.withOpacity(0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.search_rounded,
              color: AppConstants.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search doctors, specialties...',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 18,
                ),
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor,
            AppConstants.primaryColor.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(-2, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Shine effect
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                showPriceRangeDialog(context);
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}