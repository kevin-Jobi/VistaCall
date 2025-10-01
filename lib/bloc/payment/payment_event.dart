// import 'package:equatable/equatable.dart';
// import 'package:vistacall/data/models/doctor.dart';

// abstract class PaymentEvent extends Equatable {
//   const PaymentEvent();

//   @override
//   List<Object?> get props => [];
// }

// class SelectPayment extends PaymentEvent {
//   final String paymentMethod;
//   const SelectPayment(this.paymentMethod);

//   @override
//   List<Object?> get props => [paymentMethod];
// }

// class ConfirmBooking extends PaymentEvent{
//   final DoctorModel doctor;
//   final DateTime selectedDate;
//   final String selectedSlot;
//   final String paymentMethod;

//   const ConfirmBooking({
//     required this.doctor,
//     required this.selectedDate,
//     required this.selectedSlot,
//     required this.paymentMethod
//   });

//   @override
//   List<Object?> get props => [doctor,selectedDate,selectedSlot,paymentMethod];
// }

import 'package:equatable/equatable.dart';
import 'package:vistacall/data/models/doctor.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class SelectPayment extends PaymentEvent {
  final String paymentMethod;
  const SelectPayment(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class ConfirmBooking extends PaymentEvent {
  final DoctorModel doctor;
  final DateTime selectedDate;
  final String selectedSlot;
  final String paymentMethod;
  final String? userName; // Added to pass the selected patient name

  const ConfirmBooking({
    required this.doctor,
    required this.selectedDate,
    required this.selectedSlot,
    required this.paymentMethod,
    this.userName,
  });

  @override
  List<Object?> get props =>
      [doctor, selectedDate, selectedSlot, paymentMethod, userName];
}

class PaymentConfirmed extends PaymentEvent {
  final DoctorModel doctor;
  final DateTime selectedDate;
  final String selectedSlot;
  final String paymentMethod;

  const PaymentConfirmed({
    required this.doctor,
    required this.selectedDate,
    required this.selectedSlot,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props =>
      [doctor, selectedDate, selectedSlot, paymentMethod];
}