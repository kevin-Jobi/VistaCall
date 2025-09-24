import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/add_patient/patient_bloc.dart';

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

  // void _savePatient() {
  //   if (_formKey.currentState!.validate()) {
  //     final newPatient = {
  //       'firstName': _firstNameController.text,
  //       'lastName': _lastNameController.text,
  //       'gender': _gender,
  //       'age': _calculateAge(_dobController.text), // Implement age calculation
  //       'initial': _firstNameController.text.isNotEmpty ? _firstNameController.text[0] : 'A',
  //     };
  //     // Save to your data source and update the patient list
  //     Navigator.pop(context); // Close the page after saving
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD NEW FAMILY MEMBER'),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.help))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Important: You will not be able to edit these details once you have saved them!',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                const Text('Full Name'),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter first name' : null,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter last name' : null,
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                      labelText: 'Date Of Birth', hintText: 'dd/mm/yyyy'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter date of birth' : null,
                ),
                const SizedBox(height: 16),
                const Text('Gender'),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Other'),
                        value: 'Other',
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Relation'),
                TextFormField(
                  controller: _relationController,
                  decoration: const InputDecoration(
                      labelText: 'Who is this to you?',
                      hintText: 'name@email.com'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter relation' : null,
                ),
                const SizedBox(height: 16),
                const Text('Email Address'),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'name@email.com'),
                  validator: (value) => !value!.contains('@')
                      ? 'Please enter a valid email'
                      : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL')),
                    const SizedBox(width: 8),
                    ElevatedButton(
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
                            context
                                .read<PatientBloc>()
                                .add(AddPatient(patient));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('SAVE')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _calculateAge(String dob) {
    final parts = dob.split('/');
    if (parts.length != 3) return 'N/a';
    final birthDate =
        DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    return age.toString();
  }
}
