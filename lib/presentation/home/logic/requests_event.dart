part of 'requests_bloc.dart';

abstract class RequestsEvent extends Equatable {
  const RequestsEvent();
}

class LoadRequestsEvent extends RequestsEvent {
  final String? searchKey;

  const LoadRequestsEvent({this.searchKey});

  @override
  List<Object?> get props => [searchKey];
}
