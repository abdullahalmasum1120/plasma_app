part of 'update_user_form_cubit.dart';

class UpdateUserDataFormState extends Equatable {
  final String city;
  final bool isValidCity;
  final String? cityErrorMessage;
  final String thana;
  final bool isValidThana;
  final String? thanaErrorMessage;
  final String username;
  final bool isValidName;
  final String? usernameErrorMessage;
  final String bloodGroup;
  final bool isValidBloodGroup;
  final String? bloodGroupErrorMessage;

  const UpdateUserDataFormState._({
    required this.city,
    required this.isValidCity,
    required this.cityErrorMessage,
    required this.thana,
    required this.isValidThana,
    required this.thanaErrorMessage,
    required this.username,
    required this.isValidName,
    required this.usernameErrorMessage,
    required this.bloodGroup,
    required this.isValidBloodGroup,
    required this.bloodGroupErrorMessage,
  });

  factory UpdateUserDataFormState.initial() {
    return const UpdateUserDataFormState._(
      city: "",
      isValidCity: false,
      cityErrorMessage: null,
      thana: "",
      isValidThana: false,
      thanaErrorMessage: null,
      username: "",
      isValidName: false,
      usernameErrorMessage: null,
      bloodGroup: "",
      isValidBloodGroup: false,
      bloodGroupErrorMessage: null,
    );
  }

  UpdateUserDataFormState copyWith({
    String? city,
    bool? isValidCity,
    String? cityErrorMessage,
    String? thana,
    bool? isValidThana,
    String? thanaErrorMessage,
    String? username,
    bool? isValidName,
    String? usernameErrorMessage,
    String? bloodGroup,
    bool? isValidBloodGroup,
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
      isValidBloodGroup: isValidBloodGroup ?? this.isValidBloodGroup,
      isValidName: isValidName ?? this.isValidName,
      isValidCity: isValidCity ?? this.isValidCity,
      isValidThana: isValidThana ?? this.isValidThana,
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
        isValidName,
        isValidCity,
        isValidThana,
        isValidBloodGroup,
      ];
}
