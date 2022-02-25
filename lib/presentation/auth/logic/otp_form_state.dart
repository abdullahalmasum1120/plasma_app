part of 'otp_form_cubit.dart';

class OtpFormState extends Equatable {
  final OtpCode otpCode;
  final String? errorMessage;
  final bool isValid;

  const OtpFormState._({
    required this.otpCode,
    required this.errorMessage,
    required this.isValid,
  });

  factory OtpFormState.initial() {
    return const OtpFormState._(
      errorMessage: null,
      otpCode: OtpCode(code: ""),
      isValid: false,
    );
  }

  OtpFormState copyWith({
    String? errorMessage,
    OtpCode? otpCode,
    bool? isValid,
  }) {
    return OtpFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      otpCode: otpCode ?? this.otpCode,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [errorMessage, otpCode, isValid];
}
