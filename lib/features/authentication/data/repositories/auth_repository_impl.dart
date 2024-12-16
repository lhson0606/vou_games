import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/models/auth_info_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferencesService sharedPreferencesService;
  final UserCredentialService userCredentialService;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.authDataSource,
      required this.sharedPreferencesService,
      required this.userCredentialService});

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
  Future<Either<Failure, Unit>> logOut() async {
    try {
      final logOutUnit = await authDataSource.logOut().timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw ServerException());
      return Right(logOutUnit);
    } on ServerException {
      return Left(ServerFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(
      SignInEntity signInPayload) async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
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
      } on TooManyRequestsException {
        return Left(TooManyRequestsFailure());
      } on NoUserException {
        return Left(NoUserFailure());
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
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

  @override
  Future<Either<Failure, AuthInfoEntity>> checkAuthInfo() async {
    if (!(await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false))) {
      return Left(OfflineFailure());
    }
    String? tokenString = await authDataSource.checkStoredUser();
    AuthInfoModel authInfoModel = AuthInfoModel(isLoggedIn: tokenString != null, userToken: tokenString);
    AuthInfoEntity authInfoEntity = authInfoModel;
    userCredentialService.isLoggedIn = authInfoModel.isLoggedIn;
    userCredentialService.userToken = authInfoModel.userToken;
    return Right(authInfoEntity);
  }
}
