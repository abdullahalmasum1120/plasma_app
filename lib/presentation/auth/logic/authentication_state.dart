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

  const AuthExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpSendingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class OtpSentState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class OtpVerifyingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class OtpExceptionState extends AuthenticationState {
  final String message;

  const OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpVerifiedState extends AuthenticationState {
  final UserCredential userCredential;

  const OtpVerifiedState({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}
