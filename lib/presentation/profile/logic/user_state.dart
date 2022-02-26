part of 'user_cubit.dart';

class UserState extends Equatable {
  final MyUser myUser;

  const UserState._({required this.myUser});

  factory UserState.initial() => UserState._(myUser: MyUser());

  UserState copyWith({MyUser? myUser}) =>
      UserState._(myUser: myUser ?? this.myUser);

  @override
  List<Object?> get props => [myUser];
}
