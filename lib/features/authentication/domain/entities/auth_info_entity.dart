import 'package:equatable/equatable.dart';

class AuthInfoEntity extends Equatable{
  final bool isLoggedIn;
  final String? userToken;
  //#todo: add user token here?
  const AuthInfoEntity({required this.isLoggedIn, required this.userToken});

  @override
  List<Object?> get props => [isLoggedIn];
}