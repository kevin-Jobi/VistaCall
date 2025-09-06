part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentSelected extends PaymentState {
  final String paymentMethod;

  const PaymentSelected({required this.paymentMethod});

  @override
  List<Object?> get props => [paymentMethod];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  final DoctorModel? doctor;
  final DateTime? selectedDate;
  final String? selectedSlot;
  final String? paymentMethod;

  const PaymentSuccess({
    this.doctor,
    this.selectedDate,
    this.selectedSlot,
    this.paymentMethod,
  });

  @override
  List<Object?> get props =>
      [doctor, selectedDate, selectedSlot, paymentMethod];
}

class PaymentError extends PaymentState {
  final String error;

  const PaymentError(this.error);

  @override
  List<Object?> get props => [error];
}
