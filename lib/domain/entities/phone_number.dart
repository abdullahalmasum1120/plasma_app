import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

@immutable
class PhoneNumber extends Equatable {
  final String phone;

  const PhoneNumber({
    required this.phone,
  });

  bool get validate {
    if (phone.isNotEmpty) {
      if (phone.length == 14) {
        return true;
      } else {
        throw ValueException(message: "Length must be 10 without Country-code");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [phone];
}
