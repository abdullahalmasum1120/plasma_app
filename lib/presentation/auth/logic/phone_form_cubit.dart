import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';
import 'package:plasma/domain/entities/phone_number.dart';

part 'phone_form_state.dart';

class PhoneFormCubit extends Cubit<PhoneFormState> {
  PhoneFormCubit() : super(PhoneFormState.initial());

  void valueChanged(PhoneNumber phoneNumber) {
    try {
      if (phoneNumber.validate) {
        emit(state.copyWith(
          phoneNumber: phoneNumber,
          isValid: true,
          errorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        phoneNumber: phoneNumber,
        isValid: false,
        errorMessage: e.message,
      ));
    }
  }
}
