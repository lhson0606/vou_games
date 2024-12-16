part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthNotAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoggedOutState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingLoggedOutState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final String message;
  final DateTime timestamp;

  AuthErrorState({required this.message}) : timestamp = DateTime.now();

  @override
  List<Object> get props => [message, timestamp];
}

class AuthSignedInState extends AuthState {
  @override
  List<Object> get props => [];
}
