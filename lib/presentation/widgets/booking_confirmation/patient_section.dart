// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withValues(alpha: 0.3),
//             colorScheme.primaryContainer.withValues(alpha: 0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocBuilder<PatientBloc, PatientState>(
//           builder: (context, state) {
//             if (state is PatientLoaded && state.patients.isNotEmpty) {
//               selectedPatientName =
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(selectedPatientName!);
//             }
//             return Text(
//               selectedPatientName ?? widget.viewModel.model.selectedPatientName ?? 'Select Patient',
//               style: widget.theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: widget.colorScheme.onSurface,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withValues(alpha: 0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   void _showPatientSelectionBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => BlocProvider.value(
//         value: BlocProvider.of<PatientBloc>(context, listen: false),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.5,
//           maxChildSize: 0.9,
//           minChildSize: 0.3,
//           builder: (context, scrollController) => _buildPatientBottomSheet(context, scrollController),
//         ),
//       ),
//     ).then((selectedName) {
//       if (selectedName != null && selectedName is String) {
//         setState(() {
//           selectedPatientName = selectedName;
//         });
//         widget.viewModel.updateSelectedPatient(selectedName);
//         context.read<PatientBloc>().add(LoadPatients());
//       }
//     });
//   }

//   Widget _buildPatientBottomSheet(BuildContext context, ScrollController scrollController) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: widget.colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Select Patient',
//             style: widget.theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: widget.colorScheme.onSurface,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: BlocBuilder<PatientBloc, PatientState>(
//               builder: (context, state) {
//                 if (state is PatientLoading) {
//                   return Center(child: CircularProgressIndicator(color: widget.colorScheme.primary));
//                 }
//                 if (state is PatientLoaded) {
//                   if (state.patients.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'No patients found.',
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(
//                               color: widget.colorScheme.onSurfaceVariant,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             onPressed: () => _navigateToAddPatient(context),
//                             child: const Text('Add Patient'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     controller: scrollController,
//                     itemCount: state.patients.length,
//                     itemBuilder: (context, index) => _buildPatientListItem(context, state.patients[index]),
//                   );
//                 }
//                 return const Center(child: Text('Error loading patients'));
//               },
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => _navigateToAddPatient(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.colorScheme.primary,
//                 foregroundColor: widget.colorScheme.onPrimary,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: Text(
//                 'Add New Patient',
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onPrimary,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     return GestureDetector(
//       onTap: () => Navigator.pop(context, patientName),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: widget.colorScheme.surfaceVariant.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']!.substring(0, 1).toUpperCase(),
//                 style: TextStyle(
//                   color: widget.colorScheme.onPrimary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     '${patient['gender']}, ${patient['age']}',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios,
//                 color: widget.colorScheme.onSurfaceVariant, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToAddPatient(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: BlocProvider.of<PatientBloc>(context, listen: false),
//           child: const AddPatientPage(),
//         ),
//       ),
//     ).then((_) {
//       context.read<PatientBloc>().add(LoadPatients());
//     });
//   }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withValues(alpha: 0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with ViewModel's selected patient if available
//     selectedPatientName = widget.viewModel.model.selectedPatientName;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withOpacity(0.3),
//             colorScheme.primaryContainer.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocBuilder<PatientBloc, PatientState>(
//           builder: (context, state) {
//             // Only update if we have patients and no selection yet
//             if (state is PatientLoaded && 
//                 state.patients.isNotEmpty && 
//                 selectedPatientName == null) {
//               selectedPatientName = 
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(selectedPatientName!);
//               // Trigger rebuild
//               if (mounted) setState(() {});
//             }
            
//             final displayName = selectedPatientName ?? 
//                                widget.viewModel.model.selectedPatientName ?? 
//                                'Select Patient';
            
//             return Text(
//               displayName,
//               style: widget.theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: widget.colorScheme.onSurface,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   void _showPatientSelectionBottomSheet(BuildContext context) {
//     // Get the PatientBloc from the parent context
//     final patientBloc = context.read<PatientBloc>();
    
//     showModalBottomSheet<String?>(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (modalContext) => BlocProvider.value(
//         value: patientBloc,
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.5,
//           maxChildSize: 0.9,
//           minChildSize: 0.3,
//           builder: (modalContext, scrollController) => 
//               _buildPatientBottomSheet(modalContext, scrollController),
//         ),
//       ),
//     ).then((selectedName) {
//       if (selectedName != null && selectedName is String && mounted) {
//         setState(() {
//           selectedPatientName = selectedName;
//         });
//         widget.viewModel.updateSelectedPatient(selectedName);
//       }
//     });
//   }

//   Widget _buildPatientBottomSheet(BuildContext modalContext, ScrollController scrollController) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: widget.colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Select Patient',
//             style: widget.theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: widget.colorScheme.onSurface,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: BlocBuilder<PatientBloc, PatientState>(
//               builder: (context, state) {
//                 if (state is PatientLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(color: widget.colorScheme.primary),
//                   );
//                 }
//                 if (state is PatientLoaded) {
//                   if (state.patients.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person_add,
//                             size: 64,
//                             color: widget.colorScheme.onSurfaceVariant,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No patients found.',
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(
//                               color: widget.colorScheme.onSurfaceVariant,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             onPressed: () => _navigateToAddPatient(modalContext),
//                             child: const Text('Add Patient'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     controller: scrollController,
//                     itemCount: state.patients.length,
//                     itemBuilder: (context, index) => 
//                         _buildPatientListItem(context, state.patients[index]),
//                   );
//                 }
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         size: 64,
//                         color: widget.colorScheme.error,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Error loading patients',
//                         style: widget.theme.textTheme.bodyMedium?.copyWith(
//                           color: widget.colorScheme.error,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () => _navigateToAddPatient(modalContext),
//               icon: const Icon(Icons.add),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.colorScheme.primary,
//                 foregroundColor: widget.colorScheme.onPrimary,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               label: Text(
//                 'Add New Patient',
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onPrimary,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     final isSelected = selectedPatientName == patientName;
    
//     return GestureDetector(
//       onTap: () => Navigator.pop(context, patientName),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: isSelected 
//               ? widget.colorScheme.primary.withOpacity(0.1)
//               : widget.colorScheme.surfaceVariant.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: isSelected 
//               ? Border.all(color: widget.colorScheme.primary, width: 2)
//               : null,
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']!.substring(0, 1).toUpperCase(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       // color: widget.colorScheme.onSurface,
//                       color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     '${patient['gender']}, ${patient['age']}',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(
//                 Icons.check_circle,
//                 color: widget.colorScheme.primary,
//                 size: 20,
//               )
//             else
//               Icon(
//                 Icons.arrow_forward_ios,
//                 color: widget.colorScheme.onSurfaceVariant,
//                 size: 16,
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _navigateToAddPatient(BuildContext context) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: context.read<PatientBloc>(),
//           child: const AddPatientPage(),
//         ),
//       ),
//     );
    
//     if (result != null && mounted) {
//       // Refresh patients after adding
//       context.read<PatientBloc>().add(LoadPatients());
//     }
//   }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withOpacity(0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with ViewModel's selected patient if available
//     selectedPatientName = widget.viewModel.model.selectedPatientName;
    
//     // Listen to ViewModel changes for patient selection
//     widget.viewModel.addListener(_onViewModelChanged);
//   }

//   @override
//   void dispose() {
//     widget.viewModel.removeListener(_onViewModelChanged);
//     super.dispose();
//   }

//   void _onViewModelChanged() {
//     if (mounted && widget.viewModel.model.selectedPatientName != selectedPatientName) {
//       setState(() {
//         selectedPatientName = widget.viewModel.model.selectedPatientName;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withOpacity(0.3),
//             colorScheme.primaryContainer.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocListener<PatientBloc, PatientState>(
//           listener: (context, state) {
//             // Handle auto-selection outside of build
//             if (state is PatientLoaded && 
//                 state.patients.isNotEmpty && 
//                 selectedPatientName == null) {
//               final autoSelectedName = 
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(autoSelectedName);
//             }
//           },
//           child: BlocBuilder<PatientBloc, PatientState>(
//             builder: (context, state) {
//               // Use current selected patient from ViewModel
//               final displayName = selectedPatientName ?? 
//                                   widget.viewModel.model.selectedPatientName ?? 
//                                   (state is PatientLoaded && state.patients.isNotEmpty
//                                       ? '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}'
//                                       : 'Select Patient');
              
//               return Text(
//                 displayName,
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onSurface,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   // void _showPatientSelectionBottomSheet(BuildContext context) {
//   //   final patientBloc = context.read<PatientBloc>();
    
//   //   showModalBottomSheet<String?>(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     shape: const RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//   //     ),
//   //     builder: (modalContext) => BlocProvider.value(
//   //       value: patientBloc,
//   //       child: DraggableScrollableSheet(
//   //         initialChildSize: 0.5,
//   //         maxChildSize: 0.9,
//   //         minChildSize: 0.3,
//   //         builder: (modalContext, scrollController) => 
//   //             _buildPatientBottomSheet(modalContext, scrollController),
//   //       ),
//   //     ),
//   //   ).then((selectedName) {
//   //     if (selectedName != null && selectedName is String && mounted) {
//   //       // Update via ViewModel - this will trigger the listener
//   //       widget.viewModel.updateSelectedPatient(selectedName);
//   //     }
//   //   });
//   // }
//   void _showPatientSelectionBottomSheet(BuildContext context) {
//   final patientBloc = context.read<PatientBloc>();
  
//   showModalBottomSheet<String?>(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (modalContext) => BlocProvider.value(
//       value: patientBloc,
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.7, // Fixed 70% height
//         decoration: BoxDecoration(
//           color: widget.colorScheme.surface,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           children: [
//             // Header with drag handle
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: widget.colorScheme.outlineVariant.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Select Patient',
//                     style: widget.theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Content
//             Expanded(
//               child: _buildPatientContent(modalContext),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ).then((selectedName) {
//     if (selectedName != null && selectedName is String && mounted) {
//       widget.viewModel.updateSelectedPatient(selectedName);
//     }
//   });
// }

//   Widget _buildPatientBottomSheet(BuildContext modalContext, ScrollController scrollController) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: widget.colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Select Patient',
//             style: widget.theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: widget.colorScheme.onSurface,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: BlocBuilder<PatientBloc, PatientState>(
//               builder: (context, state) {
//                 if (state is PatientLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(color: widget.colorScheme.primary),
//                   );
//                 }
//                 if (state is PatientLoaded) {
//                   if (state.patients.isEmpty) {
//                     return _buildEmptyPatientsState(modalContext);
//                   }
//                   return ListView.builder(
//                     controller: scrollController,
//                     itemCount: state.patients.length,
//                     itemBuilder: (context, index) => 
//                         _buildPatientListItem(context, state.patients[index]),
//                   );
//                 }
//                 return _buildErrorState(modalContext);
//               },
//             ),
//           ),
//           _buildAddPatientButton(modalContext),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyPatientsState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.person_add,
//             size: 64,
//             color: widget.colorScheme.onSurfaceVariant,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No patients found.',
//             style: widget.theme.textTheme.bodyMedium?.copyWith(
//               color: widget.colorScheme.onSurfaceVariant,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () => _navigateToAddPatient(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: widget.colorScheme.primary,
//               foregroundColor: widget.colorScheme.onPrimary,
//             ),
//             child: const Text('Add Patient'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 64,
//             color: widget.colorScheme.error,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Error loading patients',
//             style: widget.theme.textTheme.bodyMedium?.copyWith(
//               color: widget.colorScheme.error,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddPatientButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () => _navigateToAddPatient(context),
//         icon: const Icon(Icons.add),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.colorScheme.primary,
//           foregroundColor: widget.colorScheme.onPrimary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         label: Text(
//           'Add New Patient',
//           style: widget.theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: widget.colorScheme.onPrimary,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     final isSelected = selectedPatientName == patientName || 
//                        widget.viewModel.model.selectedPatientName == patientName;
    
//     return GestureDetector(
//       onTap: () => Navigator.pop(context, patientName),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: isSelected 
//             ? widget.colorScheme.primary.withOpacity(0.1)
//             : widget.colorScheme.surfaceVariant.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: isSelected 
//             ? Border.all(color: widget.colorScheme.primary, width: 2)
//             : null,
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']!.substring(0, 1).toUpperCase(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     '${patient['gender']}, ${patient['age']}',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(Icons.check_circle, color: widget.colorScheme.primary, size: 20)
//             else
//               Icon(Icons.arrow_forward_ios, 
//                   color: widget.colorScheme.onSurfaceVariant, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _navigateToAddPatient(BuildContext context) async {
//     final patientBloc = context.read<PatientBloc>();
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: patientBloc,
//           child: const AddPatientPage(),
//         ),
//       ),
//     );
    
//     if (result != null && mounted) {
//       // Refresh patients after adding
//       patientBloc.add(LoadPatients());
//     }
//   }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withOpacity(0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with ViewModel's selected patient if available
//     selectedPatientName = widget.viewModel.model.selectedPatientName;
    
//     // Listen to ViewModel changes for patient selection
//     widget.viewModel.addListener(_onViewModelChanged);
//   }

//   @override
//   void dispose() {
//     widget.viewModel.removeListener(_onViewModelChanged);
//     super.dispose();
//   }

//   void _onViewModelChanged() {
//     if (mounted && widget.viewModel.model.selectedPatientName != selectedPatientName) {
//       setState(() {
//         selectedPatientName = widget.viewModel.model.selectedPatientName;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withOpacity(0.3),
//             colorScheme.primaryContainer.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocListener<PatientBloc, PatientState>(
//           listener: (context, state) {
//             // Handle auto-selection outside of build
//             if (state is PatientLoaded && 
//                 state.patients.isNotEmpty && 
//                 selectedPatientName == null) {
//               final autoSelectedName = 
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(autoSelectedName);
//             }
//           },
//           child: BlocBuilder<PatientBloc, PatientState>(
//             builder: (context, state) {
//               // Use current selected patient from ViewModel
//               final displayName = selectedPatientName ?? 
//                                   widget.viewModel.model.selectedPatientName ?? 
//                                   (state is PatientLoaded && state.patients.isNotEmpty
//                                       ? '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}'
//                                       : 'Select Patient');
              
//               return Text(
//                 displayName,
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onSurface,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   void _showPatientSelectionBottomSheet(BuildContext context) {
//     final patientBloc = context.read<PatientBloc>();
    
//     showModalBottomSheet<String?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (modalContext) => BlocProvider.value(
//         value: patientBloc,
//         child: Container(
//           // Fixed height - 70% of screen height
//           height: MediaQuery.of(context).size.height * 0.7,
//           decoration: BoxDecoration(
//             color: widget.colorScheme.surface,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             children: [
//               // Header with drag handle
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
//                 decoration: BoxDecoration(
//                   color: widget.colorScheme.surface,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: Column(
//                   children: [
//                     // Drag handle
//                     Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: widget.colorScheme.outlineVariant.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Select Patient',
//                                 style: widget.theme.textTheme.titleLarge?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color: widget.colorScheme.onSurface,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Choose the patient for this appointment',
//                                 style: widget.theme.textTheme.bodyMedium?.copyWith(
//                                   color: widget.colorScheme.onSurfaceVariant,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () => Navigator.of(modalContext).pop(),
//                           icon: Icon(Icons.close, color: widget.colorScheme.onSurfaceVariant),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Content
//               Expanded(
//                 child: _buildPatientContent(modalContext),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ).then((selectedName) {
//       if (selectedName != null && selectedName is String && mounted) {
//         widget.viewModel.updateSelectedPatient(selectedName);
//       }
//     });
//   }

//   Widget _buildPatientContent(BuildContext modalContext) {
//     return BlocBuilder<PatientBloc, PatientState>(
//       builder: (context, state) {
//         if (state is PatientLoading) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(40),
//               child: CircularProgressIndicator(color: widget.colorScheme.primary),
//             ),
//           );
//         }
        
//         if (state is PatientLoaded) {
//           if (state.patients.isEmpty) {
//             return _buildEmptyPatientsState(modalContext);
//           }
//           return _buildPatientsList(modalContext, state.patients);
//         }
        
//         return _buildErrorState(modalContext);
//       },
//     );
//   }

//   Widget _buildPatientsList(BuildContext context, List<dynamic> patients) {
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       itemCount: patients.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 8),
//       itemBuilder: (context, index) {
//         final patient = patients[index];
//         return _buildPatientListItem(context, patient);
//       },
//     );
//   }

//   Widget _buildEmptyPatientsState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.person_add,
//               size: 80,
//               color: widget.colorScheme.onSurfaceVariant,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No patients found',
//               style: widget.theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: widget.colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start by adding your first patient',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 32),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () => _navigateToAddPatient(context),
//                 icon: const Icon(Icons.add),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: widget.colorScheme.primary,
//                   foregroundColor: widget.colorScheme.onPrimary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 label: Text(
//                   'Add New Patient',
//                   style: widget.theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: widget.colorScheme.onPrimary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 80,
//               color: widget.colorScheme.error,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Error loading patients',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.error,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.colorScheme.primary,
//                 foregroundColor: widget.colorScheme.onPrimary,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     final isSelected = selectedPatientName == patientName || 
//                        widget.viewModel.model.selectedPatientName == patientName;
    
//     return GestureDetector(
//       onTap: () => Navigator.pop(context, patientName),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         decoration: BoxDecoration(
//           color: isSelected 
//             ? widget.colorScheme.primary.withOpacity(0.08)
//             : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: isSelected 
//             ? Border.all(color: widget.colorScheme.primary, width: 2)
//             : Border.all(color: widget.colorScheme.outline.withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']?.toString().substring(0, 1).toUpperCase() ?? 'P',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${patient['gender'] ?? 'N/A'}, ${patient['age'] ?? 'N/A'} years',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(Icons.check_circle, color: widget.colorScheme.primary, size: 24)
//             else
//               Icon(Icons.arrow_forward_ios, 
//                   color: widget.colorScheme.onSurfaceVariant, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _navigateToAddPatient(BuildContext context) async {
//     final patientBloc = context.read<PatientBloc>();
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: patientBloc,
//           child: const AddPatientPage(),
//         ),
//       ),
//     );
    
//     if (result != null && mounted) {
//       // Refresh patients after adding
//       patientBloc.add(LoadPatients());
//     }
//     // Close bottom sheet if it was open
//     Navigator.of(context, rootNavigator: true).pop();
//   }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withOpacity(0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   void initState() {
//     super.initState();
//     selectedPatientName = widget.viewModel.model.selectedPatientName;
//     widget.viewModel.addListener(_onViewModelChanged);
//   }

//   @override
//   void dispose() {
//     widget.viewModel.removeListener(_onViewModelChanged);
//     super.dispose();
//   }

//   void _onViewModelChanged() {
//     if (mounted && widget.viewModel.model.selectedPatientName != selectedPatientName) {
//       setState(() {
//         selectedPatientName = widget.viewModel.model.selectedPatientName;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withOpacity(0.3),
//             colorScheme.primaryContainer.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocListener<PatientBloc, PatientState>(
//           listener: (context, state) {
//             if (state is PatientLoaded && 
//                 state.patients.isNotEmpty && 
//                 selectedPatientName == null) {
//               final autoSelectedName = 
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(autoSelectedName);
//             }
//           },
//           child: BlocBuilder<PatientBloc, PatientState>(
//             builder: (context, state) {
//               final displayName = selectedPatientName ?? 
//                                   widget.viewModel.model.selectedPatientName ?? 
//                                   (state is PatientLoaded && state.patients.isNotEmpty
//                                       ? '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}'
//                                       : 'Select Patient');
              
//               return Text(
//                 displayName,
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onSurface,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   void _showPatientSelectionBottomSheet(BuildContext context) {
//     final patientBloc = context.read<PatientBloc>();
    
//     showModalBottomSheet<String?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (modalContext) => BlocProvider.value(
//         value: patientBloc,
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           decoration: BoxDecoration(
//             color: widget.colorScheme.surface,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             children: [
//               // Header
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
//                 decoration: BoxDecoration(
//                   color: widget.colorScheme.surface,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: Column(
//                   children: [
//                     // Drag handle
//                     Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: widget.colorScheme.outlineVariant.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Select Patient',
//                                 style: widget.theme.textTheme.titleLarge?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color: widget.colorScheme.onSurface,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Choose the patient for this appointment',
//                                 style: widget.theme.textTheme.bodyMedium?.copyWith(
//                                   color: widget.colorScheme.onSurfaceVariant,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () => Navigator.of(modalContext).pop(),
//                           icon: Icon(Icons.close, color: widget.colorScheme.onSurfaceVariant),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Content
//               Expanded(
//                 child: _buildPatientContent(modalContext),
//               ),
//               // Add New Patient Button (Always visible at bottom)
//               _buildAddPatientButton(modalContext),
//             ],
//           ),
//         ),
//       ),
//     ).then((selectedName) {
//       if (selectedName != null && selectedName is String && mounted) {
//         widget.viewModel.updateSelectedPatient(selectedName);
//       }
//     });
//   }

//   Widget _buildPatientContent(BuildContext modalContext) {
//     return BlocBuilder<PatientBloc, PatientState>(
//       builder: (context, state) {
//         if (state is PatientLoading) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(40),
//               child: CircularProgressIndicator(color: widget.colorScheme.primary),
//             ),
//           );
//         }
        
//         if (state is PatientLoaded) {
//           if (state.patients.isEmpty) {
//             return _buildEmptyPatientsState(modalContext);
//           }
//           return _buildPatientsList(modalContext, state.patients);
//         }
        
//         return _buildErrorState(modalContext);
//       },
//     );
//   }

//   Widget _buildPatientsList(BuildContext context, List<dynamic> patients) {
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       itemCount: patients.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 8),
//       itemBuilder: (context, index) {
//         final patient = patients[index];
//         return _buildPatientListItem(context, patient);
//       },
//     );
//   }

//   Widget _buildEmptyPatientsState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.person_add,
//               size: 80,
//               color: widget.colorScheme.onSurfaceVariant,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No patients found',
//               style: widget.theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: widget.colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start by adding your first patient',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 32),
//             // Add patient button in empty state
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () => _navigateToAddPatient(context),
//                 icon: const Icon(Icons.add),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: widget.colorScheme.primary,
//                   foregroundColor: widget.colorScheme.onPrimary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 label: Text(
//                   'Add New Patient',
//                   style: widget.theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: widget.colorScheme.onPrimary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 80,
//               color: widget.colorScheme.error,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Error loading patients',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.error,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.colorScheme.primary,
//                 foregroundColor: widget.colorScheme.onPrimary,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddPatientButton(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.all(20),
//       child: ElevatedButton.icon(
//         onPressed: () => _navigateToAddPatient(context),
//         icon: const Icon(Icons.person_add),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.colorScheme.primary,
//           foregroundColor: widget.colorScheme.onPrimary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 2,
//         ),
//         label: Text(
//           'Add New Patient',
//           style: widget.theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: widget.colorScheme.onPrimary,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     final isSelected = selectedPatientName == patientName || 
//                        widget.viewModel.model.selectedPatientName == patientName;
    
//     return GestureDetector(
//       onTap: () => Navigator.pop(context, patientName),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         decoration: BoxDecoration(
//           color: isSelected 
//             ? widget.colorScheme.primary.withOpacity(0.08)
//             : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: isSelected 
//             ? Border.all(color: widget.colorScheme.primary, width: 2)
//             : Border.all(color: widget.colorScheme.outline.withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']?.toString().substring(0, 1).toUpperCase() ?? 'P',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${patient['gender'] ?? 'N/A'}, ${patient['age'] ?? 'N/A'} years',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(Icons.check_circle, color: widget.colorScheme.primary, size: 24)
//             else
//               Icon(Icons.arrow_forward_ios, 
//                   color: widget.colorScheme.onSurfaceVariant, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _navigateToAddPatient(BuildContext context) async {
//     final patientBloc = context.read<PatientBloc>();
    
//     // Close the bottom sheet first
//     Navigator.of(context, rootNavigator: true).pop();
    
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: patientBloc,
//           child: const AddPatientPage(),
//         ),
//       ),
//     );
    
//     if (result != null && mounted) {
//       patientBloc.add(LoadPatients());
//     }
//   }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withOpacity(0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bloc/add_patient/patient_bloc.dart';
// import '../../../viewmodels/booking_confirmation_viewmodel.dart';
// import '../../../../presentation/widgets/bookappointments/add_patient.dart';

// class PatientSection extends StatefulWidget {
//   final BookingConfirmationViewModel viewModel;
//   final ThemeData theme;
//   final ColorScheme colorScheme;

//   const PatientSection({
//     super.key,
//     required this.viewModel,
//     required this.theme,
//     required this.colorScheme,
//   });

//   @override
//   State<PatientSection> createState() => _PatientSectionState();
// }

// class _PatientSectionState extends State<PatientSection> {
//   String? selectedPatientName;

//   @override
//   void initState() {
//     super.initState();
//     selectedPatientName = widget.viewModel.model.selectedPatientName;
//     widget.viewModel.addListener(_onViewModelChanged);
//   }

//   @override
//   void dispose() {
//     widget.viewModel.removeListener(_onViewModelChanged);
//     super.dispose();
//   }

//   void _onViewModelChanged() {
//     if (mounted && widget.viewModel.model.selectedPatientName != selectedPatientName) {
//       setState(() {
//         selectedPatientName = widget.viewModel.model.selectedPatientName;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: _buildCardDecoration(widget.colorScheme),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             _buildPatientIcon(widget.colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildPatientInfo(context)),
//             _buildSelectPatientButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientIcon(ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primaryContainer.withOpacity(0.3),
//             colorScheme.primaryContainer.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.person_rounded, color: colorScheme.primary, size: 24),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'In-Clinic Appointment for',
//           style: widget.theme.textTheme.bodySmall?.copyWith(
//             color: widget.colorScheme.onSurfaceVariant,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         BlocListener<PatientBloc, PatientState>(
//           listener: (context, state) {
//             if (state is PatientLoaded && 
//                 state.patients.isNotEmpty && 
//                 selectedPatientName == null) {
//               final autoSelectedName = 
//                   '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//               widget.viewModel.updateSelectedPatient(autoSelectedName);
//             }
//           },
//           child: BlocBuilder<PatientBloc, PatientState>(
//             builder: (context, state) {
//               final displayName = selectedPatientName ?? 
//                                   widget.viewModel.model.selectedPatientName ?? 
//                                   (state is PatientLoaded && state.patients.isNotEmpty
//                                       ? '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}'
//                                       : 'Select Patient');
              
//               return Text(
//                 displayName,
//                 style: widget.theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: widget.colorScheme.onSurface,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSelectPatientButton(BuildContext context) {
//     return TextButton(
//       onPressed: () => _showPatientSelectionBottomSheet(context),
//       style: TextButton.styleFrom(
//         backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
//         foregroundColor: widget.colorScheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: Text(
//         'Select',
//         style: widget.theme.textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: widget.colorScheme.primary,
//         ),
//       ),
//     );
//   }

//   void _showPatientSelectionBottomSheet(BuildContext context) {
//     final patientBloc = context.read<PatientBloc>();
    
//     showModalBottomSheet<String?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (modalContext) => BlocProvider.value(
//         value: patientBloc,
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           decoration: BoxDecoration(
//             color: widget.colorScheme.surface,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             children: [
//               // Header
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
//                 decoration: BoxDecoration(
//                   color: widget.colorScheme.surface,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: widget.colorScheme.outlineVariant.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Select Patient',
//                                 style: widget.theme.textTheme.titleLarge?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color: widget.colorScheme.onSurface,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Choose the patient for this appointment',
//                                 style: widget.theme.textTheme.bodyMedium?.copyWith(
//                                   color: widget.colorScheme.onSurfaceVariant,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () => Navigator.of(modalContext, rootNavigator: true).pop(),
//                           icon: Icon(Icons.close, color: widget.colorScheme.onSurfaceVariant),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Content
//               Expanded(
//                 child: _buildPatientContent(modalContext),
//               ),
//               // Add New Patient Button
//               _buildAddPatientButton(modalContext),
//             ],
//           ),
//         ),
//       ),
//     ).then((selectedName) {
//       if (selectedName != null && selectedName is String && mounted) {
//         widget.viewModel.updateSelectedPatient(selectedName);
//       }
//     });
//   }

//   Widget _buildPatientContent(BuildContext modalContext) {
//     return BlocBuilder<PatientBloc, PatientState>(
//       builder: (context, state) {
//         if (state is PatientLoading) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(40),
//               child: CircularProgressIndicator(color: widget.colorScheme.primary),
//             ),
//           );
//         }
        
//         if (state is PatientLoaded) {
//           if (state.patients.isEmpty) {
//             return _buildEmptyPatientsState(modalContext);
//           }
//           return _buildPatientsList(modalContext, state.patients);
//         }
        
//         return _buildErrorState(modalContext);
//       },
//     );
//   }

//   Widget _buildPatientsList(BuildContext context, List<dynamic> patients) {
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       itemCount: patients.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 8),
//       itemBuilder: (context, index) {
//         final patient = patients[index];
//         return _buildPatientListItem(context, patient);
//       },
//     );
//   }

//   Widget _buildEmptyPatientsState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.person_add,
//               size: 80,
//               color: widget.colorScheme.onSurfaceVariant,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No patients found',
//               style: widget.theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: widget.colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start by adding your first patient',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.onSurfaceVariant,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 80,
//               color: widget.colorScheme.error,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Error loading patients',
//               style: widget.theme.textTheme.bodyMedium?.copyWith(
//                 color: widget.colorScheme.error,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: widget.colorScheme.primary,
//                 foregroundColor: widget.colorScheme.onPrimary,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddPatientButton(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.all(20),
//       child: ElevatedButton.icon(
//         onPressed: () => _navigateToAddPatient(context),
//         icon: const Icon(Icons.person_add),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.colorScheme.primary,
//           foregroundColor: widget.colorScheme.onPrimary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 2,
//         ),
//         label: Text(
//           'Add New Patient',
//           style: widget.theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: widget.colorScheme.onPrimary,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientListItem(BuildContext context, Map<String, dynamic> patient) {
//     final patientName = '${patient['firstName']} ${patient['lastName']}';
//     final isSelected = selectedPatientName == patientName || 
//                        widget.viewModel.model.selectedPatientName == patientName;
    
//     return GestureDetector(
//       onTap: () => Navigator.of(context, rootNavigator: true).pop(patientName),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         decoration: BoxDecoration(
//           color: isSelected 
//             ? widget.colorScheme.primary.withOpacity(0.08)
//             : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: isSelected 
//             ? Border.all(color: widget.colorScheme.primary, width: 2)
//             : Border.all(color: widget.colorScheme.outline.withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: widget.colorScheme.primary,
//               child: Text(
//                 patient['firstName']?.toString().substring(0, 1).toUpperCase() ?? 'P',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patientName,
//                     style: widget.theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${patient['gender'] ?? 'N/A'}, ${patient['age'] ?? 'N/A'} years',
//                     style: widget.theme.textTheme.bodySmall?.copyWith(
//                       color: widget.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(Icons.check_circle, color: widget.colorScheme.primary, size: 24)
//             else
//               Icon(Icons.arrow_forward_ios, 
//                   color: widget.colorScheme.onSurfaceVariant, size: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   // Future<void> _navigateToAddPatient(BuildContext context) async {
//   //   try {
//   //     final patientBloc = context.read<PatientBloc>();
      
//   //     // Get the main app context for navigation
//   //     BuildContext navigatorContext = context;
//   //     // Use root navigator context for navigation if needed
//   //     final rootNavigator = Navigator.of(context, rootNavigator: true);
      
//   //     // Close bottom sheet
//   //     if (Navigator.canPop(context)) {
//   //       Navigator.of(context, rootNavigator: true).pop();
//   //     }
      
//   //     // Wait for animation to complete
//   //     await Future.delayed(const Duration(milliseconds: 300));
      
//   //     if (mounted && navigatorContext != null) {
//   //       final result = await Navigator.of(navigatorContext).push(
//   //         MaterialPageRoute(
//   //           builder: (context) => BlocProvider.value(
//   //             value: patientBloc,
//   //             child: const AddPatientPage(),
//   //           ),
//   //         ),
//   //       );
        
//   //       if (result != null) {
//   //         patientBloc.add(LoadPatients());
//   //       }
//   //     }
//   //   } catch (e) {
//   //     // Fallback navigation using root navigator
//   //     final patientBloc = context.read<PatientBloc>();
//   //     if (Navigator.canPop(context)) {
//   //       Navigator.of(context, rootNavigator: true).pop();
//   //     }
//   //     await Future.delayed(const Duration(milliseconds: 300));
      
//   //     if (mounted) {
//   //       Navigator.of(context, rootNavigator: true).push(
//   //         MaterialPageRoute(
//   //           builder: (context) => BlocProvider.value(
//   //             value: patientBloc,
//   //             child: const AddPatientPage(),
//   //           ),
//   //         ),
//   //       ).then((result) {
//   //         if (result != null) {
//   //           patientBloc.add(LoadPatients());
//   //         }
//   //       });
//   //     }
//   //   }
//   // }
//   Future<void> _navigateToAddPatient(BuildContext context) async {
//   final patientBloc = context.read<PatientBloc>();

//   // Close the bottom sheet first
//   if (Navigator.canPop(context)) {
//     Navigator.of(context, rootNavigator: true).pop();
//     await Future.delayed(const Duration(milliseconds: 300)); // Wait for animation
//   }

//   // Use root navigator to push AddPatientPage
//   final result = await Navigator.of(context, rootNavigator: true).push(
//     MaterialPageRoute(
//       builder: (context) => BlocProvider.value(
//         value: patientBloc,
//         child: const AddPatientPage(),
//       ),
//     ),
//   );

//   if (result != null && mounted) {
//     patientBloc.add(LoadPatients());
//   }
// }

//   BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
//     return BoxDecoration(
//       color: colorScheme.surface,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: colorScheme.primary.withOpacity(0.1),
//           blurRadius: 20,
//           offset: const Offset(0, 8),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/add_patient/patient_bloc.dart';
import '../../../../presentation/widgets/bookappointments/add_patient.dart';

class PatientSection extends StatefulWidget {
  final dynamic viewModel; // BookingConfirmationViewModel
  final ThemeData theme;
  final ColorScheme colorScheme;

  const PatientSection({
    super.key,
    required this.viewModel,
    required this.theme,
    required this.colorScheme,
  });

  @override
  State<PatientSection> createState() => _PatientSectionState();
}

class _PatientSectionState extends State<PatientSection> {
  String? selectedPatientName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: widget.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.colorScheme.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _buildPatientIcon(),
            const SizedBox(width: 16),
            Expanded(child: _buildPatientInfo(context)),
            _buildSelectButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.colorScheme.primaryContainer.withOpacity(0.3),
            widget.colorScheme.primaryContainer.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.person_rounded,
        color: widget.colorScheme.primary,
        size: 24,
      ),
    );
  }

  Widget _buildPatientInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'In-Clinic Appointment for',
          style: widget.theme.textTheme.bodySmall?.copyWith(
            color: widget.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            String displayName = selectedPatientName ?? 'Select Patient';
            
            if (state is PatientLoaded && state.patients.isNotEmpty) {
              // Auto-select first patient if none selected
              if (selectedPatientName == null) {
                displayName = '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
                selectedPatientName = displayName; // Cache locally
              } else {
                displayName = selectedPatientName!;
              }
            }
            
            return Text(
              displayName,
              style: widget.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: widget.colorScheme.onSurface,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSelectButton(BuildContext context) {
    return TextButton(
      onPressed: () => _showPatientSelectionBottomSheet(context),
      style: TextButton.styleFrom(
        backgroundColor: widget.colorScheme.primaryContainer.withOpacity(0.1),
        foregroundColor: widget.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        'Select',
        style: widget.theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: widget.colorScheme.primary,
        ),
      ),
    );
  }

  void _showPatientSelectionBottomSheet(BuildContext context) {
    final patientBloc = context.read<PatientBloc>();
    
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: widget.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: widget.colorScheme.outlineVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select Patient',
                          style: widget.theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: widget.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(modalContext).pop(),
                        icon: Icon(Icons.close, color: widget.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: BlocProvider.value(
                value: patientBloc,
                child: BlocBuilder<PatientBloc, PatientState>(
                  builder: (context, state) {
                    if (state is PatientLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: widget.colorScheme.primary),
                      );
                    }
                    
                    if (state is PatientLoaded) {
                      if (state.patients.isEmpty) {
                        return _buildEmptyState(modalContext);
                      }
                      return _buildPatientsList(modalContext, state.patients);
                    }
                    
                    return _buildErrorState(modalContext);
                  },
                ),
              ),
            ),
            // Add New Patient Button (Always visible)
            _buildAddPatientButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext modalContext) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add,
              size: 80,
              color: widget.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 24),
            Text(
              'No patients found',
              style: widget.theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: widget.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start by adding your first patient',
              style: widget.theme.textTheme.bodyMedium?.copyWith(
                color: widget.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext modalContext) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: widget.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading patients',
              style: widget.theme.textTheme.bodyMedium?.copyWith(
                color: widget.colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<PatientBloc>().add(LoadPatients()),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.colorScheme.primary,
                foregroundColor: widget.colorScheme.onPrimary,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientsList(BuildContext modalContext, List<dynamic> patients) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: patients.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final patient = patients[index];
        final patientName = '${patient['firstName']} ${patient['lastName']}';
        final isSelected = selectedPatientName == patientName;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPatientName = patientName;
            });
            Navigator.of(modalContext).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected 
                ? widget.colorScheme.primary.withOpacity(0.08)
                : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                ? Border.all(color: widget.colorScheme.primary, width: 2)
                : Border.all(color: widget.colorScheme.outline.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: widget.colorScheme.primary,
                  child: Text(
                    patient['firstName']?.toString().substring(0, 1).toUpperCase() ?? 'P',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        style: widget.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${patient['gender'] ?? 'N/A'}, ${patient['age'] ?? 'N/A'} years',
                        style: widget.theme.textTheme.bodySmall?.copyWith(
                          color: widget.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: widget.colorScheme.primary, size: 24)
                else
                  const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddPatientButton(BuildContext parentContext) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () => _navigateToAddPatient(parentContext),
        icon: const Icon(Icons.person_add),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.colorScheme.primary,
          foregroundColor: widget.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        label: Text(
          'Add New Patient',
          style: widget.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: widget.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToAddPatient(BuildContext context) async {
    final patientBloc = context.read<PatientBloc>();
    
    // Close the bottom sheet first
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    
    // Navigate to AddPatientPage using the main navigator context
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: patientBloc,
          child: const AddPatientPage(),
        ),
      ),
    );
    
    // Refresh patients after returning
    if (mounted) {
      patientBloc.add(LoadPatients());
    }
  }
}