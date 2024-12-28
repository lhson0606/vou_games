part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable{}

class RequestNavigateToNotificationHomepageEvent extends NotificationEvent{
  @override
  List<Object?> get props => [];
}

class FetchingNotificationEvent extends NotificationEvent{
  @override
  List<Object?> get props => [];
}

class FetchNotificationEvent extends NotificationEvent{
  @override
  List<Object?> get props => [];
}
