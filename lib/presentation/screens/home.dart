
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/presentation/widgets/doctor_grid_item.dart';

import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final viewModel = HomeViewModel(homeBloc);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 55),
                const Icon(Icons.location_on, color: Colors.white),
                const SizedBox(width: 5),
                DropdownButton<String>(
                  value: 'Bangalore',
                  dropdownColor: AppConstants.primaryColor,
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  underline: Container(),
                  items:
                      <String>[
                        'Bangalore',
                        'Mumbai',
                        'Delhi',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                icon: const Icon(Icons.person),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.profileRoute);
                },
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (viewModel.isLoading(state)) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final errorMessage = viewModel.getErrorMessage(state);
                  if (errorMessage != null) {
                    return Center(child: Text(errorMessage));
                  }

                  final doctorCategories = viewModel.getDoctorCategories(state);
                  final appointments = viewModel.getAppointments(state);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FIND YOUR DOCTOR',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Search doctors, specialties...',
                        prefixIcon: Icons.search,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Find Doctors for your Health Problem',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(doctorCategories.length, (
                          index,
                        ) {
                          final category = doctorCategories[index];
                          return GestureDetector(
                            onTap: () {
                              String department;
                              switch (category.title.toLowerCase()) {
                                case 'heart':
                                  department = 'Cardiology';
                                  break;
                                case 'skin':
                                  department = 'Dermatology';
                                  break;
                                case 'brain':
                                  department = 'Neurology';
                                  break;
                                case 'child':
                                  department = 'Pediatrics';
                                  break;
                                default:
                                  department = category.title;
                              }
                              Navigator.pushNamed(
                                context,
                                AppConstants.doctorsRoute,
                                arguments: department,
                              );
                            },
                            child: DoctorGridItem(
                              title: category.title,
                              imagePath: category.imagePath,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'General Health Facility Near you',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(child: Text('Map Placeholder')),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your Upcoming Appointments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (appointments.isNotEmpty)
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(appointments[0].doctorName),
                            subtitle: Text(
                              '${appointments[0].specialty}\n${appointments[0].date} - ${appointments[0].time}',
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              color: Colors.green,
                              child: Text(
                                appointments[0].status,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppConstants.chatRoute);
        },
        backgroundColor: AppConstants.primaryColor,
        shape: const CircleBorder(),
        child: Image.asset('assets/images/logo.png'),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              activeIcon: Icon(Icons.calendar_today, size: 28),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              activeIcon: Icon(Icons.chat, size: 28),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacementNamed(
                context,
                AppConstants.appointmentsRoute,
              );
            } else if (index == 2) {
              Navigator.pushReplacementNamed(
                context,
                AppConstants.messagesRoute,
              );
            } else if (index == 3) {
              Navigator.pushReplacementNamed(
                context,
                AppConstants.profileRoute,
              );
            }
          },
        ),
      ),
    );
  }
}
