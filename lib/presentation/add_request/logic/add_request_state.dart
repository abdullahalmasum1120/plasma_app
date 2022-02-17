part of 'add_request_cubit.dart';

abstract class AddRequestState extends Equatable {
  const AddRequestState();
}

class AddRequestInitialState extends AddRequestState {
  @override
  List<Object> get props => [];
}

class AddingRequestState extends AddRequestState {
  @override
  List<Object> get props => [];
}

class RequestAddedState extends AddRequestState {
  @override
  List<Object> get props => [];
}

class RequestExceptionState extends AddRequestState {
  final String message;

  const RequestExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
