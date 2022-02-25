import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/repositories/auth_repo.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepo _authRepo = AuthRepo();
  late StreamSubscription _userStreamSubscription;

  AppBloc() : super(AppUnAuthenticatedState()) {
    _userStreamSubscription = _authRepo.authState().listen((user) {
      if (user != null) {
        if (user.displayName != null) {
          add(AppAuthenticatedEvent());
        } else {
          add(AppUserDataUploadEvent());
        }
      } else {
        add(AppUnAuthenticatedEvent());
      }
    });
    on<AppAuthenticatedEvent>((event, emit) async {
      emit(AppAuthenticatedState());
    });
    on<AppUnAuthenticatedEvent>((event, emit) {
      emit(AppUnAuthenticatedState());
    });
    on<AppUserDataUploadEvent>((event, emit) {
      emit(AppUserDataUploadState());
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
