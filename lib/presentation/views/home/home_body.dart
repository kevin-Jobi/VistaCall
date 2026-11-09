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
      color: colorScheme.primary,
      backgroundColor: colorScheme.surface,
      onRefresh: () async => viewModel.refreshData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        // Sections carry their own horizontal padding; bottom space keeps
        // the last item clear of the large FAB.
        padding: const EdgeInsets.only(top: 20, bottom: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(context, viewModel),
            const SizedBox(height: 8),
            _buildCategoriesSection(context, categoriesToShow, viewModel),

            // Search results section
            if (viewModel.hasSearchResults) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSearchResultsHeader(
                    context, viewModel.searchResultCount),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildDoctorsSection(context, viewModel),
              ),
            ],

            const SizedBox(height: 24),
            HealthCareArticles(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, HomeViewModel viewModel) {
    return SearchSection(
      onSearchChanged: viewModel.setSearchQuery,
      onClear: viewModel.clearSearch,
      onFilter: viewModel.refreshData,
    );
  }

  Widget _buildCategoriesSection(BuildContext context,
      List<DoctorCategory> categories, HomeViewModel viewModel) {
    return DoctorCategoriesGrid(
      categories: categories,
      onCategoryTap: (category) =>
          viewModel.navigateToDepartment(context, category.title),
    );
  }

  Widget _buildErrorState(
      BuildContext context, String error, HomeViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.error.withValues(alpha: 0.08),
              ),
              child: Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.error.withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 34,
                    color: colorScheme.error,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: viewModel.refreshData,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultsHeader(BuildContext context, int count) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
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
        Expanded(
          child: Text(
            'Search Results',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$count Found',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorsSection(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.filteredDoctors.isEmpty) {
      return _buildNoResultsSection(context, viewModel);
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.filteredDoctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
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

  Widget _buildNoResultsSection(
      BuildContext context, HomeViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.12),
                ),
                child: Icon(
                  Icons.search_off_rounded,
                  size: 32,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms or browse categories above',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: viewModel.clearSearch,
                  icon: const Icon(Icons.clear, size: 18),
                  label: const Text('Clear Search'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    backgroundColor:
                        colorScheme.primary.withValues(alpha: 0.08),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => viewModel.refreshData(),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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