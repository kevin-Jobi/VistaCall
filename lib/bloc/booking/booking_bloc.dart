import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistacall/bloc/booking/booking_state.dart';

part 'booking_event.dart';
// part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingInitial()) {
    on<SelectDate>(_onSelectDate);
  }

  void _onSelectDate(SelectDate event, Emitter<BookingState> emit){
    emit(BookingSelected(date:event.date));
  }
}

