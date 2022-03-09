import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'donors_state.dart';

class DonorsCubit extends Cubit<DonorsState> {
  List<MyUser> users = <MyUser>[];
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();
  late StreamSubscription _streamSubscription;

  DonorsCubit() : super(DonorsInitialState()) {
    _streamSubscription =
        _firebaseDBRepo.usersStream().listen((List<MyUser> users) {
      this.users = users;
    });
  }

  void searchDonors({required String? searchKey}) {
    List<MyUser> searchedUser = <MyUser>[];
    searchedUser.clear();
    if (searchKey != null && searchKey.isNotEmpty) {
      emit(DonorsLoadingState());
      for (MyUser user in users) {
        if (user.username!.toLowerCase().contains(searchKey.toLowerCase())) {
          searchedUser.add(user);
        }
      }
      emit(DonorsLoadedState(users: searchedUser));
    } else {
      emit(DonorsLoadedState(users: searchedUser));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
