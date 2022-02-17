part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersLoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersInitialState extends UsersState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UsersState {
  final List<MyUser> users;

  const UserLoadedState({required this.users});

  @override
  List<Object?> get props => [users];
}
