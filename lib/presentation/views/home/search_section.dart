// import 'package:flutter/material.dart';
// import 'package:vistacall/presentation/views/home/price_range_dialog.dart';
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
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(
//           width: 2,
//           color: const Color(0xFFE3F2FD),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.12),
//             blurRadius: 20,
//             offset: const Offset(0, 6),
//             spreadRadius: -2,
//           ),
//           BoxShadow(
//             color: const Color(0xFF42A5F5).withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 2),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 6),
//           Container(
//             margin: const EdgeInsets.all(8),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppConstants.primaryColor.withOpacity(0.15),
//                   AppConstants.primaryColor.withOpacity(0.08),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: const Icon(
//               Icons.search_rounded,
//               color: AppConstants.primaryColor,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               onChanged: onSearchChanged,
//               decoration: InputDecoration(
//                 hintText: 'Search doctors, specialties...',
//                 hintStyle: TextStyle(
//                   color: Colors.grey[400],
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   letterSpacing: 0.2,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 0,
//                   vertical: 18,
//                 ),
//               ),
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Color(0xFF1A1A1A),
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.1,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//         ],
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

// lib/presentation/widgets/home/search_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/views/home/price_range_dialog.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';

class SearchSection extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilter;

  const SearchSection({
    super.key,
    this.onSearchChanged,
    this.onClear,
    this.onFilter,
  });

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late TextEditingController _searchController;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final hasText = _searchController.text.isNotEmpty;
      if (_hasText != hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get initial query from ViewModel if available
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    if (_searchController.text.isEmpty && viewModel.searchQuery.isNotEmpty) {
      _searchController.text = viewModel.searchQuery;
      _hasText = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          color: _hasText
              ? AppConstants.primaryColor.withOpacity(0.3)
              : const Color(0xFFE3F2FD),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(_hasText ? 0.2 : 0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0xFF42A5F5).withOpacity(_hasText ? 0.15 : 0.08),
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
                  AppConstants.primaryColor.withOpacity(_hasText ? 0.25 : 0.15),
                  AppConstants.primaryColor.withOpacity(_hasText ? 0.12 : 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _hasText ? Icons.search : Icons.search_rounded,
              color: AppConstants.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                widget.onSearchChanged?.call(value);
              },
              onSubmitted: (value) {
                // Optional: Handle search submission
                widget.onSearchChanged?.call(value);
              },
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
                suffixIcon: _hasText
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: AppConstants.primaryColor,
                          size: 20,
                        ),
                        onPressed: _clearSearch,
                      )
                    : null,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFilterDialog(context),
      child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  if (_hasText)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _hasText = false;
    });
    widget.onSearchChanged?.call('');
    widget.onClear?.call();
  }

  void _showFilterDialog(BuildContext context) {
    showPriceRangeDialog(context);
    widget.onFilter?.call();
  }
}
