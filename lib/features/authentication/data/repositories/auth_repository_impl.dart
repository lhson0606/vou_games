import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/network/network_info.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.networkInfo, required this.authDataSource});

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
  Future<Either<Failure, UserCredential>> signIn(
      SignInEntity signInPayload) async {
    // if (await networkInfo.isConnected.timeout(const Duration(seconds: 10), onTimeout: () => false)) {
    //   try {
    //     SignInModel signInModel = SignInModel(email: signInPayload.email, password: signInPayload.password);
    //     final userCredential = await authDataSource.signIn(signInModel).timeout(const Duration(seconds: 10), onTimeout: () => throw ServerException());
    //     return Right(userCredential);
    //   } on ExistedAccountException {
    //     return Left(ExistedAccountFailure());
    //   } on WrongPasswordException {
    //     return Left(WrongPasswordFailure());
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return Left(OfflineFailure());
    // }

    try {
      SignInModel signInModel = SignInModel(
          email: signInPayload.email, password: signInPayload.password);
      final userCredential = await authDataSource.signIn(signInModel).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw ServerException());
      return Right(userCredential);
    } on ExistedAccountException {
      return Left(ExistedAccountFailure());
    } on WrongPasswordException {
      return Left(WrongPasswordFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
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
