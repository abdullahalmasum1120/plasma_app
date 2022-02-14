part of 'add_request_form_cubit.dart';

class AddRequestFormState extends Equatable {
  final String city;
  final String? cityErrorMessage;
  final String thana;
  final String? thanaErrorMessage;
  final String hospital;
  final String? hospitalErrorMessage;
  final String bloodGroup;
  final String? bloodGroupErrorMessage;
  final String note;
  final String? noteErrorMessage;

  const AddRequestFormState._({
    required this.city,
    this.cityErrorMessage,
    required this.thana,
    this.thanaErrorMessage,
    required this.hospital,
    this.hospitalErrorMessage,
    required this.bloodGroup,
    this.bloodGroupErrorMessage,
    required this.note,
    this.noteErrorMessage,
  });

  factory AddRequestFormState.initial() {
    return const AddRequestFormState._(
      city: "",
      thana: "",
      hospital: "",
      bloodGroup: "",
      note: "",
    );
  }

  AddRequestFormState copyWith({
    String? city,
    String? cityErrorMessage,
    String? thana,
    String? thanaErrorMessage,
    String? hospital,
    String? hospitalErrorMessage,
    String? bloodGroup,
    String? bloodGroupErrorMessage,
    String? note,
    String? noteErrorMessage,
  }) {
    return AddRequestFormState._(
      city: city ?? this.city,
      cityErrorMessage: cityErrorMessage ?? this.cityErrorMessage,
      thana: thana ?? this.thana,
      thanaErrorMessage: thanaErrorMessage ?? this.thanaErrorMessage,
      hospital: hospital ?? this.hospital,
      hospitalErrorMessage: hospitalErrorMessage ?? this.hospitalErrorMessage,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      bloodGroupErrorMessage:
          bloodGroupErrorMessage ?? this.bloodGroupErrorMessage,
      note: note ?? this.note,
      noteErrorMessage: noteErrorMessage ?? this.noteErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        city,
        cityErrorMessage,
        thanaErrorMessage,
        thana,
        hospitalErrorMessage,
        hospital,
        bloodGroupErrorMessage,
        bloodGroup,
        noteErrorMessage,
        note,
      ];
}
