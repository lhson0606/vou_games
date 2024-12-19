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
