// import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
// import 'package:cure_connect_service/views/widgets/top_rated_doctors/custom_app_bar.dart';
// import 'package:cure_connect_service/views/widgets/top_rated_doctors/dr_list_item.dart';
// import 'package:cure_connect_service/views/widgets/top_rated_doctors/empty_state.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class SeeAllTopRatedDoctors extends StatelessWidget {
//   SeeAllTopRatedDoctors({super.key});

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(title: 'Top Rated Doctors'),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('doctors').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return _buildLoadingState();
//           }

//           if (snapshot.hasError) {
//             return _buildErrorState(snapshot.error.toString());
//           }

//           var topRatedDocs = _filterTopRatedDoctors(snapshot.data?.docs ?? []);

//           if (topRatedDocs.isEmpty) {
//             return EmptyState();
//           }

//           return _buildDoctorsList(topRatedDocs);
//         },
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Center(
//       child: CircularProgressIndicator(
//         color: AppColors.mainTheme,
//       ),
//     );
//   }

//   Widget _buildErrorState(String error) {
//     return Center(
//       child: Text(
//         'Error: $error',
//         style: TextStyle(color: Colors.red[400]),
//       ),
//     );
//   }

//   List<QueryDocumentSnapshot> _filterTopRatedDoctors(List<QueryDocumentSnapshot> docs) {
//     return docs.where((doc) {
//       var doctorData = doc.data() as Map<String, dynamic>;
//       var ratingStr = doctorData['rating'] as String?;
//       if (ratingStr == null) return false;

//       try {
//         double rating = double.parse(ratingStr);
//         return rating >= 4.5;
//       } catch (e) {
//         return false;
//       }
//     }).toList();
//   }

//   Widget _buildDoctorsList(List<QueryDocumentSnapshot> doctors) {
//     return ListView.builder(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       itemCount: doctors.length,
//       itemBuilder: (context, index) {
//         var doctor = doctors[index].data() as Map<String, dynamic>;
//         return DoctorListItem(doctor: doctor);
//       },
//     ); 
//   }
// }