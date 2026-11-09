import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/views/home/price_range_dialog.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'FIND YOUR DOCTOR',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: 0.4,
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
              Expanded(child: _buildSearchField(context)),
              const SizedBox(width: 12),
              _buildFilterButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: _hasText
              ? primary.withValues(alpha: 0.5)
              : colorScheme.outline.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: _hasText ? 0.16 : 0.07),
            blurRadius: 18,
            offset: const Offset(0, 6),
            spreadRadius: -2,
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
              color: primary.withValues(alpha: _hasText ? 0.16 : 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.search_rounded,
              color: primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 6),
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
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 18,
                ),
                suffixIcon: _hasText
                    ? IconButton(
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        onPressed: _clearSearch,
                      )
                    : null,
              ),
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.onSurface,
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
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final deepPrimary =
        Color.alphaBlend(Colors.black.withValues(alpha: 0.2), primary);

    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, deepPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showFilterDialog(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.tune_rounded, color: onPrimary, size: 24),
              if (_hasText)
                Positioned(
                  top: 13,
                  right: 13,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: onPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: primary, width: 2),
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
  }

  void _showFilterDialog(BuildContext context) {
    showPriceRangeDialog(context);
    widget.onFilter?.call();
  }
}