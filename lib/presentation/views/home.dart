import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/home/doctor_categories_grid.dart';
import 'package:vistacall/presentation/widgets/home/home_app_bar.dart';
import 'package:vistacall/presentation/widgets/home/map_placeholder.dart';
import 'package:vistacall/presentation/widgets/home/search_section.dart';
import 'package:vistacall/presentation/widgets/home/upcoming_appointments.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeBloc = BlocProvider.of<HomeBloc>(context);
    // final viewModel = HomeViewModel(homeBloc)..loadData();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: BlocProvider.of<HomeBloc>(context)),
        BlocProvider.value(value: BlocProvider.of<DoctorListBloc>(context))
      ],
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: const HomeAppBar(),
            body: _buildBody(context, viewModel),
            floatingActionButton: _buildFloatingActionButton(context),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: 0,
              onTap: (index) => _handleNavigation(index, context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  current is HomeLoading || current is HomeLoaded,
              builder: (context, state) {
                if (viewModel.isLoading(state)) {
                  return const Center(child: CircularProgressIndicator());
                }

                final errorMessage = viewModel.getErrorMessage(state);
                if (errorMessage != null) {
                  return Center(child: Text(errorMessage));
                }

                void onSearchChanged(String query) {
                  print('Search query changed to: $query'); // Debug log
                  viewModel.setSearchQuery(query);
                }

                final categoriesToShow =
                    viewModel.getFilteredCategories().isNotEmpty
                        ? viewModel.getFilteredCategories()
                        : viewModel.getDoctorCategories(state);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchSection(
                      onSearchChanged: onSearchChanged,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Find Doctors for your Health Problem'),
                    DoctorCategoriesGrid(
                      categories: categoriesToShow,
                      onCategoryTap: (category) =>
                          viewModel.navigateToDepartment(
                        context,
                        category.title,
                      ),
                    ),
                    if (viewModel.getFilteredDoctors().isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildSectionTitle('Matching Doctors'),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.getFilteredDoctors().length,
                        itemBuilder: (context, index) {
                          final doctor = viewModel.getFilteredDoctors()[index];
                          print(
                              'Rendering doctor: ${doctor.personal['fullName']}'); // Debug render
                          return ListTile(
                            title: Text(doctor.personal['fullName'] as String),
                            subtitle:
                                Text(doctor.personal['department'] as String),
                            onTap: () {},
                          );
                        },
                      )
                    ],
                    const SizedBox(height: 20),
                    _buildSectionTitle('General Health Facility Near you'),
                    const MapPlaceholder(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Your Upcoming Appointments'),
                    UpcomingAppointments(
                      appointments: viewModel.getAppointments(state),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppConstants.chatRoute);
      },
      backgroundColor: AppConstants.primaryColor,
      shape: const CircleBorder(),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  static void _handleNavigation(int index, BuildContext context) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
    }
  }
}
