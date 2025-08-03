import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistacall/bloc/drprofile/drprofile_state.dart';

part 'drprofile_event.dart';
// part 'drprofile_state.dart';

class DrprofileBloc extends Bloc<DrprofileEvent, DrprofileState> {
  DrprofileBloc() : super(DrProfileLoadingState()) {
    on<DrprofileEvent>((event, emit) {
    });

    
  }
}
