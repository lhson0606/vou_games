import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';

class AuthFirebaseDataSource extends AuthDataSource {
  @override
  Future<UserCredential> googleAuthentication() {
    // TODO: implement googleAuthentication
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signIn(SignInModel signIn) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signUp(SignUpModel signUp) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Unit> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

}