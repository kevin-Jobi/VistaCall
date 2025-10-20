


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