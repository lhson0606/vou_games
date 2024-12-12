import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/usescases/landing_page_usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/sign_in_entity.dart';
import '../entities/sign_up_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signInPayload);
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUpPalLoad);
  Future<Either<Failure, UserCredential>> googleSignIn();

  Future<Either<Failure, Unit>>  verifyEmail();
  Future<Either<Failure, Unit>> checkEmailVerification(Completer completer);
  Future<Either<Failure, Unit>>  logOut();

  LandingPageEntity landingPage();
}