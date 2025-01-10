import 'package:dartz/dartz.dart';
import 'package:vou_games/features/authentication/data/models/auth_info_model.dart';
import 'package:vou_games/features/authentication/data/models/post_sign_up_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';

abstract class AuthDataSource {
  Future<PostSignUpModel> signUp(SignUpModel signUp);

  Future<AuthInfoModel> signIn(SignInModel signIn);

  Future<AuthInfoModel> googleAuthentication();

  Future<Unit> verifyEmail();

  Future<Unit> logOut();

  Future<AuthInfoModel?> checkStoredUser();
}
