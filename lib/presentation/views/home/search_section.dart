// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vistacall/presentation/views/home/price_range_dialog.dart';
// import 'package:vistacall/viewmodels/home_viewmodel.dart';

// class SearchSection extends StatefulWidget {
//   final Function(String)? onSearchChanged;
//   final VoidCallback? onClear;
//   final VoidCallback? onFilter;

//   const SearchSection({
//     super.key,
//     this.onSearchChanged,
//     this.onClear,
//     this.onFilter,
//   });

//   @override
//   State<SearchSection> createState() => _SearchSectionState();
// }

// class _SearchSectionState extends State<SearchSection> {
//   late TextEditingController _searchController;
//   bool _hasText = false;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     _searchController.addListener(() {
//       final hasText = _searchController.text.isNotEmpty;
//       if (_hasText != hasText) {
//         setState(() {
//           _hasText = hasText;
//         });
//       }
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Get initial query from ViewModel if available
//     final viewModel = Provider.of<HomeViewModel>(context, listen: false);
//     if (_searchController.text.isEmpty && viewModel.searchQuery.isNotEmpty) {
//       _searchController.text = viewModel.searchQuery;
//       _hasText = true;
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

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
//                   gradient: LinearGradient(
//                     colors: [
//                       colorScheme.primary,
//                       colorScheme.primary.withValues(alpha: 0.5),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'FIND YOUR DOCTOR',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                   color: colorScheme.onSurface,
//                   letterSpacing: 0.4,
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
//               Expanded(child: _buildSearchField(context)),
//               const SizedBox(width: 12),
//               _buildFilterButton(context),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchField(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final primary = colorScheme.primary;

//     return Container(
//       height: 58,
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           width: 1.5,
//           color: _hasText
//               ? primary.withValues(alpha: 0.5)
//               : colorScheme.outline.withValues(alpha: 0.3),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: primary.withValues(alpha: _hasText ? 0.16 : 0.07),
//             blurRadius: 18,
//             offset: const Offset(0, 6),
//             spreadRadius: -2,
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
//               color: primary.withValues(alpha: _hasText ? 0.16 : 0.10),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Icon(
//               Icons.search_rounded,
//               color: primary,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 6),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 widget.onSearchChanged?.call(value);
//               },
//               onSubmitted: (value) {
//                 // Optional: Handle search submission
//                 widget.onSearchChanged?.call(value);
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search doctors, specialties...',
//                 hintStyle: TextStyle(
//                   color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
//                   fontSize: 14.5,
//                   fontWeight: FontWeight.w400,
//                   letterSpacing: 0.1,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 0,
//                   vertical: 18,
//                 ),
//                 suffixIcon: _hasText
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.cancel_rounded,
//                           color: colorScheme.onSurfaceVariant,
//                           size: 20,
//                         ),
//                         onPressed: _clearSearch,
//                       )
//                     : null,
//               ),
//               style: TextStyle(
//                 fontSize: 15,
//                 color: colorScheme.onSurface,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.1,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterButton(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final primary = colorScheme.primary;
//     final onPrimary = colorScheme.onPrimary;
//     final deepPrimary =
//         Color.alphaBlend(Colors.black.withValues(alpha: 0.2), primary);

//     return Container(
//       width: 58,
//       height: 58,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [primary, deepPrimary],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: primary.withValues(alpha: 0.35),
//             blurRadius: 16,
//             offset: const Offset(0, 6),
//             spreadRadius: -2,
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: () => _showFilterDialog(context),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Icon(Icons.tune_rounded, color: onPrimary, size: 24),
//               if (_hasText)
//                 Positioned(
//                   top: 13,
//                   right: 13,
//                   child: Container(
//                     width: 10,
//                     height: 10,
//                     decoration: BoxDecoration(
//                       color: onPrimary,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: primary, width: 2),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _clearSearch() {
//     _searchController.clear();
//     setState(() {
//       _hasText = false;
//     });
//     widget.onSearchChanged?.call('');
//     widget.onClear?.call();
//   }

//   void _showFilterDialog(BuildContext context) {
//     showPriceRangeDialog(context);
//     widget.onFilter?.call();
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/views/home/price_range_dialog.dart';
import 'package:vistacall/utils/premium_theme.dart';
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
  late FocusNode _focusNode;
  final Object _tapGroup = Object(); // keeps taps on the whole bar "inside"
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (mounted) setState(() {}); // repaint focus state
    });
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
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;

    // Border: gold when focused, soft gold when it holds a query, else glass.
    final borderColor = focused
        ? PremiumColors.accent.withValues(alpha: 0.85)
        : _hasText
            ? PremiumColors.accent.withValues(alpha: 0.45)
            : Colors.white.withValues(alpha: 0.14);

    // Keep the bar's proportions stable under extreme system font scaling.
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 0.9,
      maxScaleFactor: 1.15,
      child: TapRegion(
        groupId: _tapGroup,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _focusNode.requestFocus(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: 56,
            padding: const EdgeInsets.only(left: 16, right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: focused ? 0.13 : 0.09),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: borderColor, width: focused ? 1.2 : 1),
              boxShadow: [
                BoxShadow(
                  color: PremiumColors.accent
                      .withValues(alpha: focused ? 0.16 : 0),
                  blurRadius: 18,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder<Color?>(
                  duration: const Duration(milliseconds: 220),
                  tween: ColorTween(
                    end: focused
                        ? PremiumColors.accent
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                  builder: (_, color, __) =>
                      Icon(Icons.search_rounded, color: color, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField()),
                _buildClearButton(),
                _buildFilterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: PremiumColors.accent,
        selectionColor: PremiumColors.accent.withValues(alpha: 0.30),
        selectionHandleColor: PremiumColors.accent,
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        groupId: _tapGroup,
        onTapOutside: (_) => _focusNode.unfocus(),
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        keyboardAppearance: Brightness.dark,
        cursorColor: PremiumColors.accent,
        cursorWidth: 1.6,
        cursorHeight: 20,
        cursorRadius: const Radius.circular(2),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.25,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        // Every border state is set to none explicitly. A global
        // InputDecorationTheme (enabled/focused outline borders, fills) can
        // otherwise win over a generic `border: none` and draw a box around
        // the text. Explicit values here always take priority over the theme.
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          filled: false,
          fillColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: 'Search doctors, specialties...',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.45),
            fontSize: 14.5,
            height: 1.25,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
          ),
        ),
        onChanged: (value) {
          widget.onSearchChanged?.call(value);
        },
        onSubmitted: (value) {
          // Optional: Handle search submission
          widget.onSearchChanged?.call(value);
        },
      ),
    );
  }

  Widget _buildClearButton() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 160),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: _hasText
          ? GestureDetector(
              key: const ValueKey('clear'),
              behavior: HitTestBehavior.opaque,
              onTap: _clearSearch,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(key: ValueKey('no-clear')),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Material(
      color: PremiumColors.accent,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () => _showFilterDialog(context),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.tune_rounded,
                  color: PremiumColors.navy900, size: 20),
              if (_hasText)
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: PremiumColors.navy900,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: PremiumColors.accent, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
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
    _focusNode.requestFocus(); // stay ready for the next query
  }

  void _showFilterDialog(BuildContext context) {
    _focusNode.unfocus(); // dismiss keyboard before the dialog opens
    showPriceRangeDialog(context);
    widget.onFilter?.call();
  }
}