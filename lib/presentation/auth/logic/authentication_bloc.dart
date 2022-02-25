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
  int? forceResendingToken;
  String verificationId = "";
  final AuthRepo _authRepo = AuthRepo();

  AuthenticationBloc() : super(AuthInitialState()) {
    on<OtpVerifyingEvent>((event, emit) {
      emit(OtpVerifyingState());
    });

    on<OtpSendingEvent>((event, emit) {
      emit(OtpSendingState());
    });
    on<AuthExceptionEvent>((event, emit) {
      emit(AuthExceptionState(message: event.message));
    });

    on<OtpSentEvent>((event, emit) {
      emit(OtpSentState());
    });
    on<AuthInitialEvent>((event, emit) {
      emit(AuthInitialState());
    });
    on<OtpVerifiedEvent>((event, emit) {
      emit(OtpVerifiedState(userCredential: event.userCredential));
    });
    on<OtpExceptionEvent>((event, emit) {
      emit(OtpExceptionState(message: event.message));
    });
    on<SendOtpEvent>((event, emit) async {
      await _sendOtp(
        phoneNumber: event.phoneNumber,
        forceResendingToken: forceResendingToken,
      );
    });
    on<VerifyOtpEvent>((event, emit) async {
      PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: event.otpCode.code);
      await _signIn(
        authCredential: _phoneAuthCredential,
        verificationId: verificationId,
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
        add(OtpVerifyingEvent());

        add(OtpVerifiedEvent(
          userCredential:
              await _authRepo.signIn(authCredential: phoneAuthCredential),
        ));
      },
      phoneCodeAutoRetrievalTimeout: (String verificationId) {
        if (!isClosed) {
          add(const AuthExceptionEvent(message: "Otp Code Expired"));
        }
      },
      phoneVerificationFailed: (FirebaseAuthException firebaseAuthException) {
        add(AuthExceptionEvent(message: firebaseAuthException.code));
      },
      phoneCodeSent: (String verificationId, int? forceResendingToken) {
        this.forceResendingToken = forceResendingToken;
        this.verificationId = verificationId;
        add(OtpSentEvent());
      },
    );
  }

  Future<void> _signIn({
    required AuthCredential authCredential,
    required String verificationId,
  }) async {
    add(OtpVerifyingEvent());
    try {
      UserCredential userCredential =
          await _authRepo.signIn(authCredential: authCredential);

      add(OtpVerifiedEvent(userCredential: userCredential));
    } on AuthException catch (e) {
      add(OtpExceptionEvent(message: e.message));
    }
  }
}
