part of 'update_user_form_cubit.dart';

class UpdateUserDataFormState extends Equatable {
  final String city;
  final bool hasCityError;
  final String? cityErrorMessage;
  final String thana;
  final bool hasThanaError;
  final String? thanaErrorMessage;
  final String username;
  final bool hasUsernameError;
  final String? usernameErrorMessage;
  final String bloodGroup;
  final bool hasBloodGroupError;
  final String? bloodGroupErrorMessage;

  const UpdateUserDataFormState._({
    required this.city,
    required this.hasCityError,
    required this.cityErrorMessage,
    required this.thana,
    required this.hasThanaError,
    required this.thanaErrorMessage,
    required this.username,
    required this.hasUsernameError,
    required this.usernameErrorMessage,
    required this.bloodGroup,
    required this.hasBloodGroupError,
    required this.bloodGroupErrorMessage,
  });

  factory UpdateUserDataFormState.initial() {
    return const UpdateUserDataFormState._(
      city: "",
      hasCityError: false,
      cityErrorMessage: null,
      thana: "",
      hasThanaError: false,
      thanaErrorMessage: null,
      username: "",
      hasUsernameError: false,
      usernameErrorMessage: null,
      bloodGroup: "",
      hasBloodGroupError: false,
      bloodGroupErrorMessage: null,
    );
  }

  UpdateUserDataFormState copyWith({
    String? city,
    bool? hasCityError,
    String? cityErrorMessage,
    String? thana,
    bool? hasThanaError,
    String? thanaErrorMessage,
    String? username,
    bool? hasUsernameError,
    String? usernameErrorMessage,
    String? bloodGroup,
    bool? hasBloodGroupError,
    String? bloodGroupErrorMessage,
  }) {
    return UpdateUserDataFormState._(
      city: city ?? this.city,
      cityErrorMessage: cityErrorMessage ?? this.cityErrorMessage,
      thana: thana ?? this.thana,
      thanaErrorMessage: thanaErrorMessage ?? this.thanaErrorMessage,
      username: username ?? this.username,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      bloodGroupErrorMessage:
          bloodGroupErrorMessage ?? this.bloodGroupErrorMessage,
      hasBloodGroupError: hasBloodGroupError ?? this.hasBloodGroupError,
      hasUsernameError: hasUsernameError ?? this.hasUsernameError,
      hasCityError: hasCityError ?? this.hasCityError,
      hasThanaError: hasThanaError ?? this.hasThanaError,
    );
  }

  @override
  List<Object?> get props => [
        city,
        cityErrorMessage,
        thanaErrorMessage,
        thana,
        usernameErrorMessage,
        username,
        bloodGroupErrorMessage,
        bloodGroup,
        hasUsernameError,
        hasCityError,
        hasThanaError,
        hasBloodGroupError,
      ];
}
