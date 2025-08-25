part of 'payment_bloc.dart';

 class PaymentState extends Equatable {
  final String? paymentMethod;
  final bool isLoading;
  final String? error;
  final bool isSucess;
  const PaymentState({this.paymentMethod,this.isLoading= false,this.error,this.isSucess= false});
  
  @override
  List<Object?> get props => [paymentMethod,isLoading,error,isSucess];

  // PaymentState copyWith({String? paymentMethod}){
  //   return PaymentState(paymentMethod: paymentMethod ?? this.paymentMethod);
  // }
}

class PaymentInitial extends PaymentState{
  const PaymentInitial() : super(paymentMethod: 'Pay Online');
}

 class PaymentSelected extends PaymentState {
  const PaymentSelected({required String paymentMethod})
  : super (paymentMethod: paymentMethod);
}

class PaymentLoading extends PaymentState{
  const PaymentLoading(): super(isLoading: true);
}

class PaymentSuccess extends PaymentState{
  const PaymentSuccess(): super(isSucess: true);
}

class PaymentError extends PaymentState{
  const PaymentError(String message) : super(error: message);
}
