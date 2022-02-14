import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class City extends Equatable {
  final String city;

  const City({
    required this.city,
  });

  bool get validate {
    if (city.isNotEmpty) {
      if (RegExp(r'^[^\d\W]+$').hasMatch(city)) {
        return true;
      } else {
        throw ValueException(message: "Invalid City");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [city];
}
