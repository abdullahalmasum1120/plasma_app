part of 'donors_cubit.dart';

abstract class DonorsState extends Equatable {
  const DonorsState();
}

class DonorsLoadingState extends DonorsState {
  @override
  List<Object> get props => [];
}

class DonorsInitialState extends DonorsState {
  @override
  List<Object> get props => [];
}

class DonorsLoadedState extends DonorsState {
  final List<MyUser> users;

  const DonorsLoadedState({required this.users});

  @override
  List<Object?> get props => [users];
}

