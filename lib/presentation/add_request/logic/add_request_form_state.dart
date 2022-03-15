part of 'add_request_form_cubit.dart';

class AddRequestFormState extends Equatable {
  final String city;
  final bool hasCityError;
  final bool hasThanaError;
  final bool hasHospitalError;
  final bool hasBloodGroupError;
  final bool hasNoteError;
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
    required this.hasCityError,
    required this.hasThanaError,
    required this.hasHospitalError,
    required this.hasBloodGroupError,
    required this.hasNoteError,
    required this.city,
    required this.cityErrorMessage,
    required this.thana,
    required this.thanaErrorMessage,
    required this.hospital,
    required this.hospitalErrorMessage,
    required this.bloodGroup,
    required this.bloodGroupErrorMessage,
    required this.note,
    required this.noteErrorMessage,
  });

  factory AddRequestFormState.initial() {
    return const AddRequestFormState._(
      hasBloodGroupError: true,
      hasThanaError: true,
      hasCityError: true,
      hasHospitalError: true,
      hasNoteError: true,
      city: "",
      thana: "",
      hospital: "",
      bloodGroup: "",
      note: "",
      hospitalErrorMessage: null,
      noteErrorMessage: null,
      bloodGroupErrorMessage: null,
      cityErrorMessage: null,
      thanaErrorMessage: null,
    );
  }

  AddRequestFormState copyWith({
    bool? hasCityError,
    bool? hasThanaError,
    bool? hasHospitalError,
    bool? hasBloodGroupError,
    bool? hasNoteError,
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
      hasBloodGroupError: hasBloodGroupError ?? this.hasBloodGroupError,
      hasThanaError: hasThanaError ?? this.hasThanaError,
      hasCityError: hasCityError ?? this.hasCityError,
      hasHospitalError: hasHospitalError ?? this.hasHospitalError,
      hasNoteError: hasNoteError ?? this.hasNoteError,
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
        hasCityError,
        hasThanaError,
        hasHospitalError,
        hasBloodGroupError,
        hasNoteError,
      ];
}
