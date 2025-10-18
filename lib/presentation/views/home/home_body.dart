// lib/presentation/views/home/home_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/presentation/views/home/doctor_card.dart';
import 'package:vistacall/presentation/views/home/doctor_categories_grid.dart';
import 'package:vistacall/presentation/views/home/health_care_articles.dart';
import 'package:vistacall/presentation/views/home/search_section.dart';

import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/utils/constants.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current is HomeLoading ||
              current is HomeLoaded ||
              current is HomeError,
          builder: (context, homeState) {
            return BlocBuilder<DoctorListBloc, DoctorListState>(
              buildWhen: (previous, current) =>
                  current is DoctorListLoading || current is DoctorListLoaded,
              builder: (context, doctorState) {
                return _buildContent(
                    context, viewModel, homeState, doctorState);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeViewModel viewModel,
      HomeState homeState, DoctorListState doctorState) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Loading state
    if (viewModel.isLoading ||
        viewModel.isHomeLoading(homeState) ||
        viewModel.isDoctorListLoading(doctorState)) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        ),
      );
    }

    // Error state
    final error = viewModel.getHomeError(homeState);
    if (error != null) {
      return _buildErrorState(context, error, viewModel);
    }

    final categoriesToShow = viewModel.filteredCategories.isNotEmpty
        ? viewModel.filteredCategories
        : viewModel.getDoctorCategories(homeState);

    return RefreshIndicator(
      color: colorScheme.onPrimary,
      backgroundColor: theme.scaffoldBackgroundColor,
      onRefresh: () async => viewModel.refreshData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(context, viewModel),
            const SizedBox(height: 20),
            _buildCategoriesSection(
                context, categoriesToShow, viewModel), // Pass context

            // Search results section
            if (viewModel.hasSearchResults) ...[
              const SizedBox(height: 24),
              _buildSearchResultsHeader(context, viewModel.searchResultCount),
              const SizedBox(height: 12),
              _buildDoctorsSection(context, viewModel),
            ],

            const SizedBox(height: 32),
            HealthCareArticles(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, HomeViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SearchSection(
      onSearchChanged: viewModel.setSearchQuery,
      onClear: viewModel.clearSearch,
      onFilter: viewModel.refreshData,
    );
  }

  // Fixed: Pass context as parameter
  Widget _buildCategoriesSection(
      BuildContext context, // Add context parameter
      List<DoctorCategory> categories,
      HomeViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DoctorCategoriesGrid(
      categories: categories,
      onCategoryTap: (category) => viewModel.navigateToDepartment(
          context, category.title), // Now context is available
    );
  }

  Widget _buildErrorState(
      BuildContext context, String error, HomeViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: viewModel.refreshData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                // backgroundColor: AppConstants.primaryColor,
                // foregroundColor: Colors.white,
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultsHeader(BuildContext context, int count) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color(0xFF42A5F5),
                // Color(0xFF1E88E5),
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.8)
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Search Results',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              // color: Color(0xFF1A1A1A),
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // color: AppConstants.primaryColor.withOpacity(0.1),
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              // color: AppConstants.primaryColor.withOpacity(0.2),
              color: colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            '$count Found',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              // color: AppConstants.primaryColor,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorsSection(BuildContext context, HomeViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (viewModel.filteredDoctors.isEmpty) {
      return _buildNoResultsSection(context, viewModel);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.filteredDoctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final doctor = viewModel.filteredDoctors[index];
        return DoctorCard(
          key: ValueKey(doctor.id),
          doctor: doctor,
          onTap: () => _navigateToDoctorProfile(context, doctor),
        );
      },
    );
  }

  Widget _buildNoResultsSection(context, HomeViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // color: Colors.grey[50],
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Colors.grey[200]!),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            // color: Colors.grey[400],
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms or browse categories above',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: viewModel.clearSearch,
                icon: const Icon(Icons.clear),
                label: const Text('Clear Search'),
              ),
              ElevatedButton.icon(
                onPressed: () => viewModel.refreshData(),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: AppConstants.primaryColor,
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToDoctorProfile(BuildContext context, DoctorModel doctor) {
    Navigator.pushNamed(
      context,
      '/drprofile',
      arguments: {
        'doctor': doctor,
        'doctorId': doctor.id,
      },
    );
  }
}
