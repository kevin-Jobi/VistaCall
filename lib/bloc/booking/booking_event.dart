part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class SelectDate extends BookingEvent{
  final DateTime date;
  const SelectDate(this.date);

  @override
  List<Object> get props => [date];
}