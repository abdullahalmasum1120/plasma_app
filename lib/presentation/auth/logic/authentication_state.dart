part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthInitialState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthExceptionState extends AuthenticationState {
  final String message;

  const AuthExceptionState(this.message);

  @override
  List<Object> get props => [message];
}

class OtpSentState extends AuthenticationState {
  final String verificationId;
  final int? forceResendingToken;

  const OtpSentState(this.verificationId, this.forceResendingToken);

  @override
  List<Object> get props => [verificationId, forceResendingToken ?? 0];
}

class OtpTimeOutState extends AuthenticationState {
  final String verificationId;

  const OtpTimeOutState(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}

class OtpSendingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class OtpVerifyingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class OtpVerifiedState extends AuthenticationState {
  final UserCredential userCredential;

  const OtpVerifiedState({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}
