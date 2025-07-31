import 'package:bloc/bloc.dart';
import 'package:vistacall/bloc/welcome/welcome_event.dart';
import 'package:vistacall/bloc/welcome/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<NavigateToAuthEvent>((event, emit) async {
      emit(WelcomeNavigateState());
    });
  }
}
