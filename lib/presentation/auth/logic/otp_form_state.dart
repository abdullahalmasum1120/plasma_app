part of 'otp_form_cubit.dart';

class OtpFormState extends Equatable {
  final OtpCode otpCode;
  final String? errorMessage;

  const OtpFormState._({
    required this.otpCode,
    required this.errorMessage,
  });

  factory OtpFormState.initial() {
    return const OtpFormState._(
      errorMessage: null,
      otpCode: OtpCode(code: ""),
    );
  }

  OtpFormState copyWith({
    String? errorMessage,
    OtpCode? otpCode,
  }) {
    return OtpFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  @override
  List<Object?> get props => [errorMessage, otpCode];
}
