import 'dart:convert';

import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';

class AuthInfoModel extends AuthInfoEntity implements JsonModel {
  const AuthInfoModel({
    required super.accessToken,
    required super.refreshToken,
    required super.tokenType,
    required super.expiresIn,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AuthInfoModel.fromJson(Map<String, dynamic> json) {
    return AuthInfoModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
    );
  }
}
