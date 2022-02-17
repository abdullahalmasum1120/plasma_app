part of 'user_cubit.dart';

class UserState extends Equatable {
  final MyUser myUser;

  const UserState(this.myUser);

  @override
  List<Object?> get props => [myUser];
}
