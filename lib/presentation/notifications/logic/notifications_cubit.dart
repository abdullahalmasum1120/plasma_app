import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/notification.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();
  late StreamSubscription _streamSubscription;

  NotificationsCubit() : super(NotificationsInitialState()) {
    emit(NotificationsLoadingState());
    _streamSubscription =
        _firebaseDBRepo.notificationsStream().listen((notifications) {
      emit(NotificationsLoadedState(notifications: notifications));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
