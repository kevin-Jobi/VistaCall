// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:vistacall/bloc/payment/payment_event.dart';

// // part 'payment_event.dart';
// part 'payment_state.dart';

// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
//   late Razorpay _razorpay;
//   PaymentBloc() : super(const PaymentInitial()) {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,_handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,_handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,_handleExternalWallet);
//     on<SelectPayment>(_onSelectPayment);
//     on<ConfirmBooking>(_onConfirmBooking);
//   }

//   void _onSelectPayment(SelectPayment event, Emitter<PaymentState> emit){
//     emit(PaymentSelected(paymentMethod:event.paymentMethod));
//   }

//   Future<void> _onConfirmBooking(ConfirmBooking event, Emitter<PaymentState> emit)async{
//     emit(const PaymentLoading());

//     final user = FirebaseAuth.instance.currentUser;
//     if(user == null){
//       emit(const PaymentError('User not authenticated'));
//       return;
//     }

//     final db = FirebaseFirestore.instance;
//     final bookingsRef = db.collection('doctors').doc(event.doctor.id).collection('bookings');

//     try{
//       await db.runTransaction((transaction)async{
//         final dateStr = '${event.selectedDate.year}-${event.selectedDate.month.toString().padLeft(2,'0')}-${event.selectedDate.day.toString().padLeft(2,'0')}';
//         final slotQuery = bookingsRef
//         .where('date',isEqualTo: dateStr)
//         .where('slot',isEqualTo: event.selectedSlot)
//         .limit(1);

// final querySnapshot = await transaction.get(slotQuery as Query<Map<String, dynamic>>);
//         if (querySnapshot.docs.isNotEmpty) {
//           throw 'Slot is already booked';
//         }

//         final newBookingRef = bookingsRef.doc();
//         transaction.set(newBookingRef, {
//           'userId' :user.uid,
//           'userName':user.displayName ?? 'Kevin Jobi',
//           'date' : dateStr,
//           'slot':event.selectedSlot,
//           'paymentMethod':event.paymentMethod,
//           'paymentStatus':event.paymentMethod == 'Pay At Clinic' ? 'Pending' :'Completed',
//           'status':'Pending',
//           'createdAt':FieldValue.serverTimestamp(),
//         });
//       });

//       if(event.paymentMethod == 'Pay Online'){
//         _initiateRazorpayPayment(event,emit);
//       }else{
//         emit(const PaymentSuccess());
//       }
//     } catch(e){
//       emit(PaymentError('Booking failed: $e'));
//     }
//   }

//   void _initiateRazorpayPayment(ConfirmBooking event, Emitter<PaymentState> emit){
//     var options = {
//       'key':'rzp_test_XXXXXXXXXXXX',
//       'amount':int.parse(event.doctor.availability['fees'])*100,
//       'name':'VistaCall',
//       'description':'Doctor Booking',
//       'prefill':{
//         'contact':FirebaseAuth.instance.currentUser?.phoneNumber ??'',
//         'email':FirebaseAuth.instance.currentUser?.email??''
//       }
//     };
//     _razorpay.open(options);
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response){

//   }

//   void _handlePaymentError(PaymentFailureResponse response){

//   }

//   void _handleExternalWallet(ExternalWalletResponse response){

//   }

//   @override
//   void onClose(){
//     _razorpay.clear();
//     super.onClose();
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/payment/payment_event.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vistacall/bloc/payment/payment_event.dart';
import 'package:vistacall/data/models/doctor.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  late Razorpay _razorpay;

  PaymentBloc() : super(const PaymentInitial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    on<SelectPayment>(_onSelectPayment);
    on<ConfirmBooking>(_onConfirmBooking);
  }

  void _onSelectPayment(SelectPayment event, Emitter<PaymentState> emit) {
    emit(PaymentSelected(paymentMethod: event.paymentMethod));
  }

  Future<void> _onConfirmBooking(ConfirmBooking event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const PaymentError('User not authenticated'));
      return;
    }

    final db = FirebaseFirestore.instance;
    final slotsRef = db.collection('doctors').doc(event.doctor.id).collection('slots');
    final bookingsRef = db.collection('doctors').doc(event.doctor.id).collection('bookings');
    final dateStr = '${event.selectedDate.year}-${event.selectedDate.month.toString().padLeft(2, '0')}-${event.selectedDate.day.toString().padLeft(2, '0')}';
    final slotId = '${dateStr}_${event.selectedSlot}'; // Unique ID for slot

    try {
      await db.runTransaction((transaction) async {
        final slotDocRef = slotsRef.doc(slotId);
        final slotDoc = await transaction.get(slotDocRef);

        if (slotDoc.exists && slotDoc.get('isBooked') == true) {
          throw 'Slot is already booked';
        }

        // Create or update slot as booked
        transaction.set(slotDocRef, {
          'date': dateStr,
          'slot': event.selectedSlot,
          'isBooked': true,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Create booking
        final newBookingRef = bookingsRef.doc();
        transaction.set(newBookingRef, {
          'userId': user.uid,
          'userName': user.displayName ?? 'Kevin Jobi',
          'date': dateStr,
          'slot': event.selectedSlot,
          'paymentMethod': event.paymentMethod,
          'paymentStatus': event.paymentMethod == 'Pay At Clinic' ? 'Pending' : 'Completed',
          'status': 'Pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
      });

      if (event.paymentMethod == 'Pay Online') {
        _initiateRazorpayPayment(event, emit);
      } else {
        emit(const PaymentSuccess());
      }
    } catch (e) {
      emit(PaymentError('Booking failed: $e'));
    }
  }

  void _initiateRazorpayPayment(ConfirmBooking event, Emitter<PaymentState> emit) {
    var options = {
      'key': 'rzp_test_XXXXXXXXXXXX', // Replace with your Razorpay test key
      'amount': int.parse(event.doctor.availability['fees']) * 100, // In paise
      'name': 'VistaCall',
      'description': 'Doctor Booking',
      'prefill': {
        'contact': FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
        'email': FirebaseAuth.instance.currentUser?.email ?? '',
      },
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment success - booking already saved
    // Optionally update payment status if needed
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment failed - consider rolling back the booking
    // For simplicity, leave as is; in production, delete the booking on failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}