part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckLoggingInEvent extends AuthEvent{}

class AuthLoggedOutEvent extends AuthEvent{}

class AuthSignedInEvent extends AuthEvent{}

class AuthCheckLoggingInEvent extends AuthEvent{}

class SignInWithEmailAndPassEvent extends AuthEvent {
  final SignInEntity signInEntity;
  SignInWithEmailAndPassEvent({required this.signInEntity});
  @override
  List<Object> get props => [signInEntity];
}
