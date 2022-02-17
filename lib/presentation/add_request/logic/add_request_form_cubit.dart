import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';
import 'package:plasma/domain/entities/blood_group.dart';
import 'package:plasma/domain/entities/city.dart';
import 'package:plasma/domain/entities/hospital.dart';
import 'package:plasma/domain/entities/note.dart';
import 'package:plasma/domain/entities/thana.dart';

part 'add_request_form_state.dart';

class AddRequestFormCubit extends Cubit<AddRequestFormState> {
  AddRequestFormCubit() : super(AddRequestFormState.initial());

  void hospitalChanged(Hospital hospital) {
    try {
      if (hospital.validate) {
        emit(state.copyWith(
          hospital: hospital.name,
          hasHospitalError: false,
          hospitalErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        hospital: hospital.name,
        hasHospitalError: true,
        hospitalErrorMessage: e.message,
      ));
    }
  }

  void cityChanged(City city) {
    try {
      if (city.validate) {
        emit(state.copyWith(
          city: city.city,
          hasCityError: false,
          cityErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        city: city.city,
        hasCityError: true,
        cityErrorMessage: e.message,
      ));
    }
  }

  void thanaChanged(Thana thana) {
    try {
      if (thana.validate) {
        emit(state.copyWith(
          thana: thana.thana,
          hasThanaError: false,
          thanaErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        thana: thana.thana,
        hasThanaError: true,
        thanaErrorMessage: e.message,
      ));
    }
  }

  void bloodGroupChanged(BloodGroup bloodGroup) {
    try {
      if (bloodGroup.validate) {
        emit(state.copyWith(
          bloodGroup: bloodGroup.group,
          hasBloodGroupError: false,
          bloodGroupErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        bloodGroup: bloodGroup.group,
        hasBloodGroupError: true,
        bloodGroupErrorMessage: e.message,
      ));
    }
  }

  void noteChanged(Note note) {
    try {
      if (note.validate) {
        emit(state.copyWith(
          note: note.note,
          hasNoteError: false,
          noteErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        note: note.note,
        hasNoteError: true,
        noteErrorMessage: e.message,
      ));
    }
  }
}
