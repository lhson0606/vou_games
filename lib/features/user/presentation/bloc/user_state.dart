part of 'user_bloc.dart';

abstract class UserState extends Equatable{}

final class UserProfileLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserProfileLoadedState extends UserState {
  final UserProfileEntity userProfile;

  UserProfileLoadedState({required this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

final class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserProfileErrorState extends UserState {
  final String message;

  UserProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RequestNavigateToUserHomepageState extends UserState {
  final Widget homepage = const UserHomepage();
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}
