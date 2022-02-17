import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();
  late StreamSubscription _userStreamSubscription;
  final String uid;

  UserCubit(this.uid) : super(UserState(MyUser())) {
    _userStreamSubscription =
        _firebaseDBRepo.userStream(uid: uid).listen((MyUser user) {
      emit(UserState(user));
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
