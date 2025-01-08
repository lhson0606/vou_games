import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/models/auth_info_model.dart';
import 'package:vou_games/features/authentication/data/models/post_sign_up_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';
import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/post_sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/configs/keys/preference_key.dart' as preKeys;

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
  Future<Either<Failure, AuthInfoEntity>> googleSignIn() {
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
      saveUserCredential(null);
      // remove from local
      saveToUserService(null);
      return Right(logOutUnit);
    } on ServerException {
      return Left(ServerFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, AuthInfoEntity>> signIn(
      SignInEntity signInPayload) async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        SignInModel signInModel = SignInModel(
            username: signInPayload.username, password: signInPayload.password);
        final userCredential = await authDataSource.signIn(signInModel).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw ServerException());
        saveUserCredential(userCredential);
        saveToUserService(userCredential);
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
      } on ExceptionWithMessage catch (e) {
        return Left(FailureWithMessage(message: e.message));
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, PostSignUpEntity>> signUp(
      SignUpEntity signUpPalLoad) async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        final SignUpModel signUpModel = SignUpModel(
            username: signUpPalLoad.username,
            email: signUpPalLoad.email,
            phoneNumber: signUpPalLoad.phoneNumber,
            password: signUpPalLoad.password);
        final PostSignUpModel authInfoModel = await authDataSource
            .signUp(signUpModel)
            .timeout(const Duration(seconds: 10),
                onTimeout: () => throw ServerException());
        return Right(authInfoModel);
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on ExceptionWithMessage catch (e) {
        return Left(FailureWithMessage(message: e.message));
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthInfoEntity?>> checkAuthInfo() async {
    if (!(await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false))) {
      return Left(OfflineFailure());
    }
    AuthInfoModel? authInfoModel = loadUserCredential();
    saveToUserService(authInfoModel);
    return Right(authInfoModel);
  }

  void saveToUserService(AuthInfoModel? authInfoModel) {
    // logout case
    if (authInfoModel == null) {
      userCredentialService.isLoggedIn = false;
      userCredentialService.userToken = null;
      return;
    }

    userCredentialService.isLoggedIn = authInfoModel != null;
    userCredentialService.userToken = authInfoModel.accessToken;
  }

  AuthInfoModel? loadUserCredential() {
    String? authInfoModelData = sharedPreferencesService
        .getString(preKeys.AuthPreferenceKey.storedCredential);
    AuthInfoModel? authInfoModel = authInfoModelData != null
        ? AuthInfoModel.fromJson(jsonDecode(authInfoModelData))
        : null;

    // check if token is expired
    if (authInfoModel != null && isExpired(authInfoModel)) {
      saveUserCredential(null);
      return null;
    }

    return authInfoModel;
  }

  bool isExpired(AuthInfoModel authInfoModel) {
    return DateTime.now().millisecondsSinceEpoch > authInfoModel.expiresIn;
  }

  saveUserCredential(AuthInfoEntity? authInfoEntity) {
    if (authInfoEntity == null) {
      sharedPreferencesService
          .removeString(preKeys.AuthPreferenceKey.storedCredential);
      return;
    }

    sharedPreferencesService.saveString(
        preKeys.AuthPreferenceKey.storedCredential, jsonEncode(authInfoEntity));
  }
}
