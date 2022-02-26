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
      if (RegExp(r'^\+8801[13-9]\d{8}$').hasMatch(phone)) {
        return true;
      } else {
        throw ValueException(message: "Invalid Phone number");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [phone];
}
