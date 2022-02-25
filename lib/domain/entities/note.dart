import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class Note extends Equatable {
  final String note;

  const Note({
    required this.note,
  });

  bool get validate {
    if (note.isNotEmpty) {
      if (RegExp(r'^[A-Z a-z]+$').hasMatch(note)) {
        return true;
      } else {
        throw ValueException(message: "Invalid Note");
      }
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [note];
}
