part of 'update_user_data_cubit.dart';

abstract class UpdateUserDataState extends Equatable {
  const UpdateUserDataState();
}

class UpdateUserDataInitialState extends UpdateUserDataState {
  @override
  List<Object> get props => [];
}

class UpdatingUserDataState extends UpdateUserDataState {
  @override
  List<Object> get props => [];
}

class UpdatedUserDataState extends UpdateUserDataState {
  @override
  List<Object> get props => [];
}

class UpdatedUserDataExceptionState extends UpdateUserDataState {
  final String message;

  const UpdatedUserDataExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
