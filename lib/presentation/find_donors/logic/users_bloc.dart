import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  List<MyUser> users = <MyUser>[];
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();
  late final StreamSubscription _streamSubscription;

  UsersBloc() : super(UsersInitialState()) {
    _streamSubscription =
        _firebaseDBRepo.usersStream().listen((List<MyUser> users) {
      this.users = users;
      add(const LoadUserEvent());
    });
    on<LoadUserEvent>((event, emit) {
      emit(UsersLoadingState());
      List<MyUser> searchedUser = <MyUser>[];
      if (event.searchKey == null) {
        emit(UserLoadedState(users: users));
      } else {
        for (MyUser user in users) {
          if (user.username!.contains(event.searchKey!)) {
            searchedUser.add(user);
          }
        }
        emit(UserLoadedState(users: searchedUser));
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
