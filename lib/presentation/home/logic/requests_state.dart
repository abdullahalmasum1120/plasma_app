part of 'requests_bloc.dart';

abstract class RequestsState extends Equatable {
  const RequestsState();
}

class RequestsLoadingState extends RequestsState {
  @override
  List<Object> get props => [];
}

class RequestsLoadedState extends RequestsState {
  final List<BloodRequest> requests;

  const RequestsLoadedState({required this.requests});

  @override
  List<Object?> get props => [requests];
}
