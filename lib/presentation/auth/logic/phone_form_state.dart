part of 'phone_form_cubit.dart';

class PhoneFormState extends Equatable {
  final PhoneNumber phoneNumber;
  final bool isValid;
  final String? errorMessage;

  const PhoneFormState._({
    required this.phoneNumber,
    required this.errorMessage,
    required this.isValid,
  });

  factory PhoneFormState.initial() {
    return const PhoneFormState._(
      errorMessage: null,
      phoneNumber: PhoneNumber(phone: ""),
      isValid: false,
    );
  }

  PhoneFormState copyWith({
    String? errorMessage,
    PhoneNumber? phoneNumber,
    bool? isValid,
  }) {
    return PhoneFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [errorMessage, phoneNumber, isValid];
}
