part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable{}

final class NotificationInitial extends NotificationState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToNotificationHomepageState extends NotificationState {
  final Widget homepage = const NotificationHomepage();
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}

final class FetchingNotificationState extends NotificationState {
  @override
  List<Object?> get props => [];
}

final class NotificationLoadedState extends NotificationState {
  final List<NotificationEntity> notifications;

  NotificationLoadedState(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

final class NotificationErrorState extends NotificationState {
  final String error;

  NotificationErrorState(this.error);

  @override
  List<Object?> get props => [error];
}