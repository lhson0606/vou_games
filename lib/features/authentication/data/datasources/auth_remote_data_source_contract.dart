import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';

abstract class AuthDataSource {
  Future<UserCredential> signUp(SignUpModel signUp);

  Future<UserCredential> signIn(SignInModel signIn);

  Future<UserCredential> googleAuthentication();

  Future<Unit> verifyEmail();
}
