class SignUpEntity {
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final String role = 'PLAYER';

  const SignUpEntity({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}
