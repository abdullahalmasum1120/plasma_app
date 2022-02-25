import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';
import 'package:plasma/domain/entities/blood_group.dart';
import 'package:plasma/domain/entities/city.dart';
import 'package:plasma/domain/entities/thana.dart';
import 'package:plasma/domain/entities/username.dart';

part 'update_user_form_state.dart';

class UpdateUserDataFormCubit extends Cubit<UpdateUserDataFormState> {
  UpdateUserDataFormCubit() : super(UpdateUserDataFormState.initial());

  void usernameChanged(Username username) {
    try {
      if (username.validate) {
        emit(state.copyWith(
          username: username.name,
          isValidName: true,
          usernameErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        username: username.name,
        isValidName: false,
        usernameErrorMessage: e.message,
      ));
    }
  }

  void cityChanged(City city) {
    try {
      if (city.validate) {
        emit(state.copyWith(
          city: city.city,
          isValidCity: true,
          cityErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        city: city.city,
        isValidCity: false,
        cityErrorMessage: e.message,
      ));
    }
  }

  void thanaChanged(Thana thana) {
    try {
      if (thana.validate) {
        emit(state.copyWith(
          thana: thana.thana,
          isValidThana: true,
          thanaErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        thana: thana.thana,
        isValidThana: false,
        thanaErrorMessage: e.message,
      ));
    }
  }

  void bloodGroupChanged(BloodGroup bloodGroup) {
    try {
      if (bloodGroup.validate) {
        emit(state.copyWith(
          bloodGroup: bloodGroup.group,
          isValidBloodGroup: true,
          bloodGroupErrorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        bloodGroup: bloodGroup.group,
        isValidBloodGroup: false,
        bloodGroupErrorMessage: e.message,
      ));
    }
  }
}
