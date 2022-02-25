part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class OtpSendingEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthInitialEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OtpVerifiedEvent extends AuthenticationEvent {
  final UserCredential userCredential;

  const OtpVerifiedEvent({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class AuthExceptionEvent extends AuthenticationEvent {
  final String message;

  const AuthExceptionEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpExceptionEvent extends AuthenticationEvent {
  final String message;

  const OtpExceptionEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpSentEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OtpVerifyingEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthenticationEvent {
  final PhoneNumber phoneNumber;

  const SendOtpEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthenticationEvent {
  final OtpCode otpCode;

  const VerifyOtpEvent({
    required this.otpCode,
  });

  @override
  List<Object?> get props => [otpCode];
}
