part of 'user_bloc.dart';

abstract class UserState extends Equatable{}

final class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToUserHomepageState extends UserState {
  final Widget homepage = const UserHomepage();

  @override
  List<Object?> get props => [];
}
