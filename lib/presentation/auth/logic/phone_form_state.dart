part of 'phone_form_cubit.dart';

class PhoneFormState extends Equatable {
  final PhoneNumber phoneNumber;
  final bool hasError;
  final String? errorMessage;

  const PhoneFormState._({
    required this.phoneNumber,
    required this.errorMessage,
    required this.hasError,
  });

  factory PhoneFormState.initial() {
    return const PhoneFormState._(
      errorMessage: null,
      phoneNumber: PhoneNumber(phone: ""),
      hasError: false,
    );
  }

  PhoneFormState copyWith({
    String? errorMessage,
    PhoneNumber? phoneNumber,
    bool? hasError,
  }) {
    return PhoneFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hasError: hasError??this.hasError,
    );
  }

  @override
  List<Object?> get props => [errorMessage, phoneNumber, hasError];
}
