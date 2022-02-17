part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class LoadUserEvent extends UsersEvent {
  final String? searchKey;

  const LoadUserEvent({
    this.searchKey,
  });

  @override
  List<Object?> get props => [searchKey];
}
