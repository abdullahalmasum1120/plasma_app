import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';
import 'package:plasma/domain/entities/otp_code.dart';
import 'package:plasma/domain/entities/phone_number.dart';

part 'otp_form_state.dart';

class OtpFormCubit extends Cubit<OtpFormState> {
  OtpFormCubit() : super(OtpFormState.initial());

  void valueChanged(OtpCode otpCode) {
    try {
      if (otpCode.validate) {
        emit(state.copyWith(
          otpCode: otpCode,
          errorMessage: null,
        ));
      }
    } on ValueException catch (e) {
      emit(state.copyWith(
        otpCode: otpCode,
        errorMessage: e.message,
      ));
    }
  }
}
