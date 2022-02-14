import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class BloodGroup extends Equatable {
  final String group;

  const BloodGroup({
    required this.group,
  });

  bool get validate {
    if (group.isNotEmpty) {
      if (RegExp(r'^(A|B|AB|O)[+-]$').hasMatch(group)) {
        return true;
      } else {
        throw ValueException(message: "Invalid Group");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [group];
}
