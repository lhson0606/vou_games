import 'package:equatable/equatable.dart';

class AuthInfoEntity extends Equatable{
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  const AuthInfoEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  bool get isLoggedIn => accessToken.isNotEmpty;

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenType, expiresIn];
}