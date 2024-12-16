import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String email;
  final String password;
  final bool rememberUser;

  const SignInEntity({
    required this.email,
    required this.password,
    this.rememberUser = false,
  });

  @override
  List<Object?> get props => [email, password, rememberUser];
}
