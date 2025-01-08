import 'dart:convert';

import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity implements JsonModel{
  const SignUpModel({required String username, required String email, required String phoneNumber, required String password })
      : super(username: username, email: email, phoneNumber: phoneNumber, password: password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}