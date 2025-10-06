import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/utils/constants.dart';

class DoctorListScreen extends StatefulWidget {
  final String department;

  const DoctorListScreen({super.key, required this.department});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  @override
  void initState() {
    super.initState();
    final doctorListBloc = BlocProvider.of<DoctorListBloc>(context);
    doctorListBloc.add(FetchDoctorsByDepartment(widget.department));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: BlocBuilder<DoctorListBloc, DoctorListState>(
        builder: (context, state) {
          if (state is DoctorListLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppConstants.primaryColor,
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading doctors...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DoctorListErrorState) {
            return _buildErrorState(state.error);
          } else if (state is DoctorListLoaded) {
            final doctors = state.doctors;
            if (doctors.isEmpty) {
              return _buildEmptyState();
            }
            return Column(
              children: [
                _buildHeader(doctors.length),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return _buildDoctorCard(context, doctor);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.department} Doctors',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                'Find your specialist',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.85),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(0.1),
            AppConstants.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.medical_services_rounded,
                  color: AppConstants.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count Doctors Available',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    'Choose the best for you',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildSortButton(),
        ],
      ),
    );
  }

  Widget _buildSortButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: PopupMenuButton(
        color: const Color.fromARGB(255, 237, 246, 251),
        icon: Icon(
          Icons.tune_rounded,
          color: AppConstants.primaryColor,
          size: 22,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        offset: const Offset(0, 50),
        itemBuilder: (BuildContext context) {
          
          return [
            _buildPopupMenuItem(
              'Experience: Low to High',
              Icons.trending_up_rounded,
            ),
            _buildPopupMenuItem(
              'Experience: High to Low',
              Icons.trending_down_rounded,
            ),
            _buildPopupMenuItem(
              'Price: Low to High',
              Icons.attach_money_rounded,
            ),
            _buildPopupMenuItem(
              'Price: High to Low',
              Icons.money_off_rounded,
            ),
          ];
        },
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String text, IconData icon) {
    return PopupMenuItem(
      
      value: text,
      child: Row(
        children: [
          
          Icon(icon, size: 20, color: AppConstants.primaryColor),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, dynamic doctor) {
    final fullName = doctor.personal?['fullName']?.toString() ?? 'Unknown';
    final experience = doctor.availability?['yearsOfExperience']?.toString() ?? 'N/A';
    final fees = doctor.availability?['fees']?.toString() ?? 'N/A';
    final imageUrl = doctor.personal?['profileImageUrl']?.toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.pushNamed(context, '/drprofile', arguments: {
              'doctor': doctor,
              'doctorId': doctor.id,
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildDoctorAvatar(imageUrl),
                const SizedBox(width: 16),
                Expanded(child: _buildDoctorInfo(fullName, experience, fees)),
                _buildBookButton(context, doctor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorAvatar(String? imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(0.2),
            AppConstants.primaryColor.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.transparent,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
        child: imageUrl == null
            ? Icon(
                Icons.person_rounded,
                color: AppConstants.primaryColor,
                size: 32,
              )
            : null,
      ),
    );
  }

  Widget _buildDoctorInfo(String name, String experience, String fees) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _buildInfoChip(
              Icons.work_outline_rounded,
              '$experience yrs',
              const Color(0xFF4CAF50),
            ),
            _buildInfoChip(
              Icons.payments_outlined,
              '₹$fees',
              const Color(0xFFFF9800),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton(BuildContext context, dynamic doctor) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.pushNamed(context, '/drprofile', arguments: {
              'doctor': doctor,
              'doctorId': doctor.id,
            });
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_rounded, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medical_services_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Doctors Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No doctors available in this department',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
// import 'package:vistacall/utils/constants.dart';

// class DoctorListScreen extends StatefulWidget {
//   final String department;

//   const DoctorListScreen({super.key, required this.department});

//   @override
//   State<DoctorListScreen> createState() => _DoctorListScreenState();
// }

// class _DoctorListScreenState extends State<DoctorListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final doctorListBloc = BlocProvider.of<DoctorListBloc>(context);
//     doctorListBloc.add(FetchDoctorsByDepartment(widget.department));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppConstants.primaryColor,
//         title: Text('${widget.department} Doctor'),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: BlocBuilder<DoctorListBloc, DoctorListState>(
//         builder: (context, state) {
//           if (state is DoctorListLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is DoctorListErrorState) {
//             return Center(child: Text(state.error));
//           } else if (state is DoctorListLoaded) {
//             final doctors = state.doctors;
//             print('Rendering ${doctors.length} doctors'); // Debug log
//             if (doctors.isEmpty) {
//               return const Center(
//                   child: Text('No doctors found for this department'));
//             }
//             // return doctors.isEmpty
//             //     ? const Center(child: Text('No doctors found for this department')):
//             return Stack(children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 30),
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: doctors.length,
//                   itemBuilder: (context, index) {
//                     final doctor = doctors[index];
//                     final fullName = doctor.personal?['fullName']?.toString() ??
//                         'Unknown'; //
//                     final experience = //
//                         doctor.availability?['yearsOfExperience']
//                                 ?.toString() ?? //
//                             'N/A'; //
//                     final fees =
//                         doctor.availability?['fees']?.toString() ?? 'N/A'; //
//                     final imageUrl =
//                         doctor.personal?['profileImageUrl']?.toString(); //

//                     return Card(
//                       elevation: 2,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.grey,
//                           backgroundImage:
//                               imageUrl != null ? NetworkImage(imageUrl) : null,
//                           child: imageUrl == null
//                               ? const Icon(Icons.person, color: Colors.white)
//                               : null,
//                         ),
//                         title: Text(
//                           doctor.personal['fullName'] as String,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(
//                             'Experience: ${doctor.availability['yearsOfExperience']} years | Fees: ${doctor.availability['fees'] ?? 'N/A'}'),
//                         trailing: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/drprofile',
//                                 arguments: {
//                                   'doctor': doctor,
//                                   'doctorId': doctor.id,
//                                 });
//                           },
//                           child: const Text('Book'),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                   top: 1,
//                   right: 10,
//                   child: PopupMenuButton(
//                       icon: const Icon(Icons.sort),
//                       itemBuilder: (BuildContext context) {
//                         return [
//                           const PopupMenuItem(
//                               value: 'experience: Low to High',
//                               child: Text('experience: Low to High')),
//                           const PopupMenuItem(
//                               value: 'experience: High to Low',
//                               child: Text('experience: High to Low')),
//                           const PopupMenuItem(
//                               value: 'Price: Low to High',
//                               child: Text('Price: Low to High')),
//                           const PopupMenuItem(
//                               value: 'Price: High to Low',
//                               child: Text('Price: High to Low')),
//                         ];
//                       }))
//             ]);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }


