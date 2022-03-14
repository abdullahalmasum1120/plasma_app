part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationsLoadingState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsInitialState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoadedState extends NotificationsState {
  final List<Notification> notifications;

  const NotificationsLoadedState({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}
