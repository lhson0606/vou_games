import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String username;
  final String password;
  final bool rememberUser;

  const SignInEntity({
    required this.username,
    required this.password,
    this.rememberUser = false,
  });

  @override
  List<Object?> get props => [username, password, rememberUser];
}
