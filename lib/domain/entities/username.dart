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
        return true;
      } else {
        throw ValueException(message: "Length must be greater then 3");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [name];
}
