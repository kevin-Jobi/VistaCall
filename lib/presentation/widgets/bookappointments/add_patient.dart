

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/add_patient/patient_bloc.dart';

// class AddPatientPage extends StatefulWidget {
//   const AddPatientPage({super.key});

//   @override
//   _AddPatientPageState createState() => _AddPatientPageState();
// }

// class _AddPatientPageState extends State<AddPatientPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _dobController = TextEditingController();
//   String _gender = 'Male';
//   final _relationController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _dobController.dispose();
//     _relationController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ADD NEW FAMILY MEMBER'),
//         actions: const [IconButton(onPressed: null, icon: Icon(Icons.help))],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Important: You will not be able to edit these details once you have saved them!',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text('Full Name'),
//                 TextFormField(
//                   controller: _firstNameController,
//                   decoration: const InputDecoration(labelText: 'First Name'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please enter first name' : null,
//                 ),
//                 TextFormField(
//                   controller: _lastNameController,
//                   decoration: const InputDecoration(labelText: 'Last Name'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please enter last name' : null,
//                 ),
//                 TextFormField(
//                   controller: _dobController,
//                   decoration: const InputDecoration(
//                       labelText: 'Date Of Birth', hintText: 'dd/mm/yyyy'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please enter date of birth' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 const Text('Gender'),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: RadioListTile<String>(
//                         title: const Text('Male'),
//                         value: 'Male',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                     ),
//                     Expanded(
//                       child: RadioListTile<String>(
//                         title: const Text('Female'),
//                         value: 'Female',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                     ),
//                     Expanded(
//                       child: RadioListTile<String>(
//                         title: const Text('Other'),
//                         value: 'Other',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const Text('Relation'),
//                 TextFormField(
//                   controller: _relationController,
//                   decoration: const InputDecoration(
//                       labelText: 'Who is this to you?',
//                       hintText: 'name@email.com'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please enter relation' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 const Text('Email Address'),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(hintText: 'name@email.com'),
//                   validator: (value) =>
//                       value == null || !value.contains('@') ? 'Please enter a valid email' : null,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('CANCEL'),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           final patient = {
//                             'firstName': _firstNameController.text,
//                             'lastName': _lastNameController.text,
//                             'age': _calculateAge(_dobController.text),
//                             'gender': _gender,
//                             'relation': _relationController.text,
//                             'email': _emailController.text,
//                           };
//                           context.read<PatientBloc>().add(AddPatient(patient));
//                           Navigator.pop(context); // Return to modal
//                         }
//                       },
//                       child: const Text('SAVE'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _calculateAge(String dob) {
//     final parts = dob.split('/');
//     if (parts.length != 3) return 'N/A';
//     final birthDate =
//         DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
//     final now = DateTime.now();
//     final age = now.year - birthDate.year;
//     return age.toString();
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/add_patient/patient_bloc.dart';
import 'package:intl/intl.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  String _gender = 'Male';
  final _relationController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _relationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF6C63FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Family Member',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline, color: Color(0xFF6C63FF)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6C63FF).withOpacity(0.1),
                      const Color(0xFF6C63FF).withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Color(0xFF6C63FF),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'These details cannot be edited once saved. Please ensure accuracy.',
                        style: TextStyle(
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Personal Information', Icons.person_outline),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      hint: 'Enter first name',
                      icon: Icons.badge_outlined,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter first name' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      hint: 'Enter last name',
                      icon: Icons.badge_outlined,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter last name' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _dobController,
                      label: 'Date of Birth',
                      hint: 'dd/mm/yyyy',
                      icon: Icons.cake_outlined,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please select date of birth' : null,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Gender', Icons.wc_outlined),
                    const SizedBox(height: 12),
                    _buildGenderSelector(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Relationship & Contact', Icons.family_restroom_outlined),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _relationController,
                      label: 'Relationship',
                      hint: 'e.g., Mother, Father, Spouse',
                      icon: Icons.people_outline,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter relationship' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'name@email.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value == null || !value.contains('@') ? 'Please enter a valid email' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final patient = {
                              'firstName': _firstNameController.text,
                              'lastName': _lastNameController.text,
                              'age': _calculateAge(_dobController.text),
                              'gender': _gender,
                              'relation': _relationController.text,
                              'email': _emailController.text,
                            };
                            context.read<PatientBloc>().add(AddPatient(patient));
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Member',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
            filled: true,
            fillColor: const Color(0xFFF8F9FE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        _buildGenderOption('Male', Icons.male),
        const SizedBox(width: 12),
        _buildGenderOption('Female', Icons.female),
        const SizedBox(width: 12),
        _buildGenderOption('Other', Icons.transgender),
      ],
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _gender == gender;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _gender = gender),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C63FF) : const Color(0xFFF8F9FE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF6C63FF) : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                gender,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateAge(String dob) {
    final parts = dob.split('/');
    if (parts.length != 3) return 'N/A';
    final birthDate =
        DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    return age.toString();
  }
}