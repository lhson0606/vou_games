part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckLoggingInEvent extends AuthEvent {}

class AuthLoggedOutEvent extends AuthEvent {}

class AuthSignedInEvent extends AuthEvent {}

class AuthCheckLoggingInEvent extends AuthEvent {}

class SignInWithUsernameAndPassEvent extends AuthEvent {
  final SignInEntity signInEntity;

  SignInWithUsernameAndPassEvent({required this.signInEntity});

  @override
  List<Object> get props => [signInEntity];
}

class SignUpWithEmailAndPassEvent extends AuthEvent {
  final SignUpEntity signUpEntity;

  SignUpWithEmailAndPassEvent({required this.signUpEntity});

  @override
  List<Object> get props => [signUpEntity];
}
