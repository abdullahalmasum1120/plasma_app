import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

@immutable
class OtpCode extends Equatable {
  final String code;

  const OtpCode({
    required this.code,
  });

  bool get validate {
    if (code.isNotEmpty) {
      if (code.length == 6) {
        return true;
      } else {
        throw ValueException(message: "Otp must be 6 digits");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [code];
}
