// part of 'booking_bloc.dart';

import 'package:equatable/equatable.dart';

class BookingState extends Equatable {
  final DateTime? selectedDate;
  const BookingState({this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
  BookingState copyWith({DateTime? selectedDate}) {
    return BookingState(selectedDate: selectedDate ?? this.selectedDate);
  }
}

final class BookingInitial extends BookingState {
  const BookingInitial() : super(selectedDate: null);
}

class BookingSelected extends BookingState{
  const BookingSelected({required DateTime date}) : super(selectedDate: date);
}
