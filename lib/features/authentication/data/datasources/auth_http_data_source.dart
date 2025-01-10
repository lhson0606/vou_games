import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/network/result_message.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/models/post_sign_up_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';
import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:http/http.dart' as http;

import '../models/auth_info_model.dart';

class AuthHttpDataSource extends AuthDataSource {
  @override
  Future<AuthInfoModel?> checkStoredUser() {
    return Future.value(null);
  }

  @override
  Future<AuthInfoModel> googleAuthentication() {
    // TODO: implement googleAuthentication
    throw UnimplementedError();
  }

  @override
  Future<Unit> logOut() {
    // we don't need to implement this method
    return Future.value(unit);
  }

  @override
  Future<AuthInfoModel> signIn(SignInModel signIn) async {
    final url = Uri.parse(config.Auth.login);
    var response = null;

    try {
      response = await http.post(url,
          headers: config.headers, body: signIn.toJsonString());
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException();
    }

    try {
      ResultMessage res = ResultMessage.fromResponse(response);

      if (res.status == 200 || res.status == 201) {
        return AuthInfoModel.fromJson(res.data as Map<String, dynamic>);
      }

      throw ExceptionWithMessage(res.message);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<PostSignUpModel> signUp(SignUpModel signUp) async {
    final url = Uri.parse(config.Auth.register);
    var response = null;

    try {
      response = await http.post(url,
          headers: config.headers, body: signUp.toJsonString());
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException();
    }

    try {
      ResultMessage res = ResultMessage.fromResponse(response);

      if (res.status == 200 || res.status == 201) {
        return PostSignUpModel(
            username: signUp.username, password: signUp.password);
      }

      if (res.status == 400) {
        throw ExceptionWithMessage(res.message);
      }

      throw UnimplementedError();
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }
  }

  @override
  Future<Unit> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
