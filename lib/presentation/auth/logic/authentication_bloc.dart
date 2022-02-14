import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/core/exceptions/auth_exception.dart';
import 'package:plasma/data/repositories/auth_repo.dart';
import 'package:plasma/domain/entities/otp_code.dart';
import 'package:plasma/domain/entities/phone_number.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo _authRepo = AuthRepo();

  AuthenticationBloc() : super(AuthInitialState()) {
    on<OtpVerifyingEvent>((event, emit) {
      emit(OtpVerifyingState());
    });

    on<OtpSendingEvent>((event, emit) {
      emit(OtpSendingState());
    });
    on<AuthExceptionEvent>((event, emit) {
      emit(AuthExceptionState(event.message));
    });

    on<OtpSentEvent>((event, emit) {
      emit(OtpSentState(event.verificationId, event.forceResendingToken));
    });

    on<OtpTimeOutEvent>((event, emit) {
      emit(OtpTimeOutState(event.verificationId));
    });
    on<AuthInitialEvent>((event, emit) {
      emit(AuthInitialState());
    });
    on<OtpVerifiedEvent>((event, emit) {
      emit(OtpVerifiedState(userCredential: event.userCredential));
    });
    on<SendOtpEvent>((event, emit) async {
      await _sendOtp(phoneNumber: event.phoneNumber);
    });
    on<VerifyOtpEvent>((event, emit) async {
      await _signIn(
        authCredential: PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.otpCode.code,
        ),
      );
    });
  }

  Future<void> _sendOtp({
    int? forceResendingToken,
    required PhoneNumber phoneNumber,
  }) async {
    add(OtpSendingEvent());
    await _authRepo.sendOtp(
      forceResendingToken: forceResendingToken,
      phoneNumber: phoneNumber,
      phoneVerificationCompleted:
          (PhoneAuthCredential phoneAuthCredential) async {
        await _signIn(authCredential: phoneAuthCredential);
      },
      phoneCodeAutoRetrievalTimeout: (String verificationId) {
        add(OtpTimeOutEvent(verificationId));
      },
      phoneVerificationFailed: (FirebaseAuthException firebaseAuthException) {
        add(AuthExceptionEvent("${firebaseAuthException.message}"));
      },
      phoneCodeSent: (String verificationId, int? forceResendingToken) {
        add(OtpSentEvent(verificationId, forceResendingToken));
      },
    );
  }

  Future<void> _signIn({required AuthCredential authCredential}) async {
    add(OtpVerifyingEvent());
    try {
      UserCredential userCredential =
          await _authRepo.signIn(authCredential: authCredential);
      if (userCredential.user != null) {
        add(OtpVerifiedEvent(userCredential: userCredential));
      }
    } on AuthException catch (e) {
      add(AuthExceptionEvent(e.message));
    }
  }
}
