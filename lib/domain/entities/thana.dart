import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class Thana extends Equatable {
  final String thana;

  const Thana({
    required this.thana,
  });

  bool get validate {
    if (thana.isNotEmpty) {
      if (RegExp(r'^[^\d\W]+$').hasMatch(thana)) {
        return true;
      } else {
        throw ValueException(message: "Invalid Thana");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [thana];
}
