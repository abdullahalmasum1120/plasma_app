part of 'upload_bloc.dart';

abstract class UploadInitialEvent extends Equatable {
  const UploadInitialEvent();
}

class UploadEvent extends UploadInitialEvent {
  final Reference storageReference;
  final File file;
  final DocumentReference? documentReference;
  final String? fieldName;
  final Function(String)? onComplete;

  const UploadEvent({
    required this.storageReference,
    required this.file,
    this.documentReference,
    this.fieldName,
    this.onComplete,
  });

  @override
  List<Object?> get props =>
      [storageReference, file, documentReference, fieldName, onComplete];
}

class UploadingEvent extends UploadInitialEvent {
  final double progress;

  const UploadingEvent(this.progress);

  @override
  List<Object?> get props => [progress];
}

class UploadedEvent extends UploadInitialEvent {
  final String downloadUrl;

  const UploadedEvent({required this.downloadUrl});

  @override
  List<Object?> get props => [downloadUrl];
}
