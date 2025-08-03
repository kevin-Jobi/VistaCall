// part of 'drprofile_bloc.dart';

import 'package:vistacall/bloc/profile/profile_state.dart';

abstract class DrprofileState {}

class DrProfileLoadingState extends DrprofileState {}

class DrProfileLoadedState extends DrprofileState{
  final String name;
  final String email;
  final String? photoURL;

  DrProfileLoadedState({required this.name, required this.email, required this.photoURL});
}

class DrProfileErrorState extends DrprofileState{
  final String error;

  DrProfileErrorState(this.error);
}

//  class DrprofileInitial extends DrprofileState {}
