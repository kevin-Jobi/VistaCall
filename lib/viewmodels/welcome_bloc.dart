import 'package:bloc/bloc.dart';

abstract class WelcomeEvent {}

class NavigateToAuthEvent extends WelcomeEvent {}

abstract class WelcomeState {}

class WelcomeInitialState extends WelcomeState {}

class WelcomeNavigateState extends WelcomeState {}

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<NavigateToAuthEvent>((event, emit) async {
      emit(WelcomeNavigateState());
    });
  }
}