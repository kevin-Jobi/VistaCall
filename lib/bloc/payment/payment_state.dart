// part of 'payment_bloc.dart';

//  class PaymentState extends Equatable {
//   final String? paymentMethod;
//   final bool isLoading;
//   final String? error;
//   final bool isSucess;
//   const PaymentState({this.paymentMethod,this.isLoading= false,this.error,this.isSucess= false});
  
//   @override
//   List<Object?> get props => [paymentMethod,isLoading,error,isSucess];

//   // PaymentState copyWith({String? paymentMethod}){
//   //   return PaymentState(paymentMethod: paymentMethod ?? this.paymentMethod);
//   // }
// }

// class PaymentInitial extends PaymentState{
//   const PaymentInitial() : super(paymentMethod: 'Pay Online');
// }

//  class PaymentSelected extends PaymentState {
//   const PaymentSelected({required String paymentMethod})
//   : super (paymentMethod: paymentMethod);
// }

// class PaymentLoading extends PaymentState{
//   const PaymentLoading(): super(isLoading: true);
// }

// class PaymentSuccess extends PaymentState{
//   const PaymentSuccess(): super(isSucess: true);
// }

// class PaymentError extends PaymentState{
//   const PaymentError(String message) : super(error: message);
// }

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
  List<Object?> get props => [doctor, selectedDate, selectedSlot, paymentMethod];
}

class PaymentError extends PaymentState {
  final String error;

  const PaymentError(this.error);

  @override
  List<Object?> get props => [error];
}