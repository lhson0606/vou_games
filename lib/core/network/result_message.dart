import 'dart:convert';

import 'package:http/http.dart';

class ResultMessage {
  final int status;
  final String message;
  final Object? data;

  ResultMessage({
    required this.status,
    required this.message,
    this.data,
  });

  factory ResultMessage.fromResponse(Response response) {
    return ResultMessage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  factory ResultMessage.fromJson(Map<String, dynamic> json) {
    return ResultMessage(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
