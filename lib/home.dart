import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/home_bloc.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final viewModel = HomeViewModel(homeBloc);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                  dropdownColor: Colors.blue,
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
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
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
                      const Text(
                        'FIND YOUR DOCTOR',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search doctors, specialties...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 249, 248, 248),
                        ),
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
                          return _buildGridItem(
                            category.title,
                            category.imagePath,
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
          Positioned(
            left: 16,
            right: 16,
            bottom: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'ASK CARE AI\n20000+ health queries resolved in last ...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Image.asset(
            imagePath,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
