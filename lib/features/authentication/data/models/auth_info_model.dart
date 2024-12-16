import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';

class AuthInfoModel extends AuthInfoEntity {
  const AuthInfoModel({required super.isLoggedIn, required super.userToken});
}