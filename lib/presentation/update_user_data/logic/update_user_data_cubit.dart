import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();

  UpdateUserDataCubit() : super(UpdateUserDataInitialState());

  Future<void> createUserData(MyUser myUser) async {
    emit(UpdatingUserDataState());

    MyUser user = await _firebaseDBRepo.createUser(myUser: myUser).whenComplete(
        () => FirebaseAuth.instance.currentUser
            ?.updateDisplayName(myUser.username));

    if (user.username != null) {
      emit(UpdatedUserDataState());
    } else {
      emit(const UpdatedUserDataExceptionState(
          message: "Unknown error Occurred Updating Data"));
    }
  }
}
