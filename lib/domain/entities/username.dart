import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class Username extends Equatable {
  final String name;

  const Username({
    required this.name,
  });

  bool get validate {
    if (name.isNotEmpty) {
      if (name.length > 3) {
        if (RegExp(r'^[A-Z a-z]+$').hasMatch(name)) {
          return true;
        } else {
          throw ValueException(message: "Invalid Username(Use only alphabetic letters)");
        }
      } else {
        throw ValueException(message: "Username is too short");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [name];
}
