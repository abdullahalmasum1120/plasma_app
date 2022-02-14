part of 'phone_form_cubit.dart';

class PhoneFormState extends Equatable {
  final PhoneNumber phoneNumber;
  final String? errorMessage;

  const PhoneFormState._({
    required this.phoneNumber,
    required this.errorMessage,
  });

  factory PhoneFormState.initial() {
    return const PhoneFormState._(
      errorMessage: null,
      phoneNumber: PhoneNumber(phone: ""),
    );
  }

  PhoneFormState copyWith({
    String? errorMessage,
    PhoneNumber? phoneNumber,
  }) {
    return PhoneFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [errorMessage, phoneNumber];
}
