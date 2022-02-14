import 'package:equatable/equatable.dart';
import 'package:plasma/core/exceptions/value_exception.dart';

class Note extends Equatable {
  final String note;

  const Note({
    required this.note,
  });

  bool get validate {
    if (note.isNotEmpty) {
      return true;
    } else {
      throw ValueException(message: "* Required");
    }
  }

  @override
  List<Object?> get props => [note];
}
