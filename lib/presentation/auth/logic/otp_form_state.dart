part of 'otp_form_cubit.dart';

class OtpFormState extends Equatable {
  final OtpCode otpCode;
  final String? errorMessage;
  final bool hasError;

  const OtpFormState._({
    required this.otpCode,
    required this.errorMessage,
    required this.hasError,
  });

  factory OtpFormState.initial() {
    return const OtpFormState._(
      errorMessage: null,
      otpCode: OtpCode(code: ""),
      hasError: false,
    );
  }

  OtpFormState copyWith({
    String? errorMessage,
    OtpCode? otpCode,
    bool? hasError,
  }) {
    return OtpFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      otpCode: otpCode ?? this.otpCode,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [errorMessage, otpCode, hasError];
}
