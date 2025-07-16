import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PasswordVisibilityEvent {}

class TogglePasswordVisibility extends PasswordVisibilityEvent {}

class PasswordVisibilityState {
  final bool isVisible;

  PasswordVisibilityState(this.isVisible);
}

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityState(false)) {
    on<TogglePasswordVisibility>((event, emit) {
      emit(PasswordVisibilityState(!state.isVisible));
    });
  }
}
