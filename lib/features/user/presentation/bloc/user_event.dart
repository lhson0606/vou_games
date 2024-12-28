part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{}

final class RequestNavigateToUserHomepageEvent extends UserEvent{
  @override
  List<Object?> get props => [];
}

final class FetchUserProfileEvent extends UserEvent{
  @override
  List<Object?> get props => [];
}
