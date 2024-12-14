import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const SignUpModel({required String email, required String password })
      : super( email: email, password: password);
}