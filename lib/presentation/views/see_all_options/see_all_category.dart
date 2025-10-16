// import 'package:cure_connect_service/views/widgets/all_category/dr_list.dart';
// import 'package:cure_connect_service/views/widgets/all_category/header_app_bar.dart';
// import 'package:cure_connect_service/views/widgets/all_category/list_view_builder.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class SeeAllCategoryPage extends StatelessWidget {
//   SeeAllCategoryPage({super.key}); 

//   @override
//   Widget build(BuildContext context) {
//     final RxString selectedCategory = 'All'.obs;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               buildHeader(),
//               const SizedBox(height: 20),
//               buildCategories(selectedCategory),
//               const SizedBox(height: 20),
//               Expanded(child: buildDoctorsList(selectedCategory)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }