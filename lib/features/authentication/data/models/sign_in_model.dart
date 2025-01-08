import 'dart:convert';

import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity implements JsonModel{
  const SignInModel({required super.username,required super.password});

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}