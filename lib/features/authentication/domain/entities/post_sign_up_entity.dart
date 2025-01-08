import 'package:equatable/equatable.dart';

class PostSignUpEntity extends Equatable {
  final String username;
  final String password;
  final bool rememberUser;

  const PostSignUpEntity({
    required this.username,
    required this.password,
    this.rememberUser = true,
  });

  @override
  List<Object?> get props => [username, password, rememberUser];
}
