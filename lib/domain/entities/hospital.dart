import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class Hospital extends Equatable {
  final String name;

  const Hospital({
    required this.name,
  });

  bool get validate {
    if (name.isNotEmpty) {
      if (RegExp(r'^[A-Z a-z]+$').hasMatch(name)) {
        return true;
      } else {
        throw ValueException(message: "Invalid Hospital");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [name];
}
