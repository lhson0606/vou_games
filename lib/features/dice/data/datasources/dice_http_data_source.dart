import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/network/result_message.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/dice/data/datasources/dice_remote_data_source_contract.dart';
import 'package:vou_games/features/dice/data/models/dice_result_model.dart';
import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:http/http.dart' as http;

class DiceHttpDataSource implements DiceDataSource {
  final UserCredentialService userCredentialService;

  DiceHttpDataSource({required this.userCredentialService});

  @override
  Future<DiceResultModel> rollDice(int gameId) async {
    final url = Uri.parse(config.ShakeGame.playShakeGame);

    http.Response response;

    try {
      response = await http
          .post(body: {'gameId': gameId}, url, headers: config.headers);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ExceptionWithMessage('Error fetching dice result');
    }

    try {
      ResultMessage resultMessage = ResultMessage.fromResponse(response);

      print(resultMessage);
      throw UnimplementedError();
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);

      // TODO: implement rollDice
      throw UnimplementedError();
    }
  }
}
