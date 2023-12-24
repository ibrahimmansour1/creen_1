part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoadingMore extends NotificationsState {}

class NotificationsDone extends NotificationsState {}

class NotificationsError extends NotificationsState {}

class NotificationsLoadingCount extends NotificationsState {}
