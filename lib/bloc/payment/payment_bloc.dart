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
    on<PaymentConfirmed>(_onPaymentConfirmed);
  }

  void _onSelectPayment(SelectPayment event, Emitter<PaymentState> emit) {
    emit(PaymentSelected(paymentMethod: event.paymentMethod));
  }

  Future<void> _onConfirmBooking(
      ConfirmBooking event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const PaymentError('User not authenticated'));
      return;
    }

    final db = FirebaseFirestore.instance;
    final slotsRef =
        db.collection('doctors').doc(event.doctor.id).collection('slots');
    final bookingsRef =
        db.collection('doctors').doc(event.doctor.id).collection('bookings');
    final dateStr =
        '${event.selectedDate.year}-${event.selectedDate.month.toString().padLeft(2, '0')}-${event.selectedDate.day.toString().padLeft(2, '0')}';
    final slotId = '${dateStr}_${event.selectedSlot}'; // Unique ID for slot

    final userId = user.uid;
    final patientsRef =
        db.collection('users').doc(userId).collection('patients');
    final patientSnapshot = await patientsRef.get();
    if (patientSnapshot.docs.isEmpty) {
      await patientsRef.add({
        'firstName': event.userName?.split(' ').first ?? 'New',
        'lastName': event.userName?.split(' ').last ?? 'User',
        'createdAt': FieldValue.serverTimestamp(),
        'gendder': 'Unknown',
        'age': 0,
        'relation': 'Self',
      });
    }

    try {
      await db.runTransaction((transaction) async {
        final slotDocRef = slotsRef.doc(slotId);
        final slotDoc = await transaction.get(slotDocRef);

        if (slotDoc.exists && slotDoc.get('isBooked') == true) {
          throw 'Slot is already booked';
        }

        // Create or update slot as booked
        transaction.set(
            slotDocRef,
            {
              'date': dateStr,
              'slot': event.selectedSlot,
              'isBooked': true,
              'createdAt': FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true));

        // Create booking with selected patient name
        final newBookingRef = bookingsRef.doc();
        transaction.set(newBookingRef, {
          'userId': user.uid,
          'userName': event.userName ??
              user.displayName ??
              'Anuraj', // Use selected name or fallback
          'date': dateStr,
          'slot': event.selectedSlot,
          'paymentMethod': event.paymentMethod,
          'paymentStatus':
              event.paymentMethod == 'Pay Online' ? 'Completed' : 'Pending',
          'status': 'Pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
      });

      if (event.paymentMethod == 'Pay Online') {
        _initiateRazorpayPayment(event, emit);
      } else {
        emit(PaymentSuccess(
          doctor: event.doctor,
          selectedDate: event.selectedDate,
          selectedSlot: event.selectedSlot,
          paymentMethod: event.paymentMethod,
        ));
      }
    } catch (e) {
      emit(PaymentError('Booking failed: $e'));
    }
  }

  void _onPaymentConfirmed(PaymentConfirmed event, Emitter<PaymentState> emit) {
    emit(PaymentSuccess(
        doctor: event.doctor,
        selectedDate: event.selectedDate,
        selectedSlot: event.selectedSlot,
        paymentMethod: event.paymentMethod));
  }

  ConfirmBooking? _currentBooking;

  void _initiateRazorpayPayment(
      ConfirmBooking event, Emitter<PaymentState> emit) async {
    _currentBooking = event;
    var options = {
      'key': 'rzp_test_R9stRRhluMbO3S',
      'amount': int.parse(event.doctor.availability['fees']) * 100,
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
    print('Payment success: ${response.paymentId}');
    if (_currentBooking != null) {
      add(PaymentConfirmed(
        doctor: _currentBooking!.doctor,
        selectedDate: _currentBooking!.selectedDate,
        selectedSlot: _currentBooking!.selectedSlot,
        paymentMethod: _currentBooking!.paymentMethod,
      ));
      _currentBooking = null; // Clear after use
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment failed - emit error state and consider rolling back
    emit(PaymentError('Payment failed: ${response.message}'));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    emit(PaymentError('External wallet selected: ${response.walletName}'));
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}
