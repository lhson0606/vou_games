import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, Unit>> checkEmailVerification(Completer completer) {
    // TODO: implement checkEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  LandingPageEntity landingPage() {
    // TODO: implement landingPage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signInPayload) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUpPalLoad) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}