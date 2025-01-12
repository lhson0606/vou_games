import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/common/data/models/reward_piece_model.dart';
import 'package:vou_games/core/common/data/models/reward_voucher_model.dart';
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
    if (!userCredentialService.isLoggedIn) {
      throw NoUserException();
    }

    final url = Uri.parse(config.ShakeGame.playShakeGame);

    http.Response response;

    try {
      response = await http.post(
          headers: config.getAuthorizedHeaders(userCredentialService.userToken),
          body: jsonEncode({'gameId': gameId} as Map<String, dynamic>),
          url);
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

      if (resultMessage.status == 200 || resultMessage.status == 201) {
        if(resultMessage.message == 'lose') {
          return DiceResultModel(isPlayerWon: false, reward: null);
        }

        try {
          RewardPieceModel diceReward = RewardPieceModel.fromJson(
              ((resultMessage.data as Map<String, dynamic>)['item']
                as Map<String, dynamic>)['piece'] as Map<String, dynamic>);
          return DiceResultModel.pieceReward(isPlayerWin: true, reward: diceReward);
        } catch (e){
          FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: e));
        }

        try {
          RewardVoucherModel diceReward = RewardVoucherModel.fromJson(
              ((resultMessage.data as Map<String, dynamic>)['item']
                as Map<String, dynamic>)['voucher'] as Map<String, dynamic>);
          return DiceResultModel.voucherReward(isPlayerWin: true, reward: diceReward);
        } catch (e) {
          FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: e));
        }

        return DiceResultModel(isPlayerWon: false, reward: null);
      } else {
        throw ExceptionWithMessage('Error fetching dice result');
      }

      throw UnimplementedError();
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);

      // TODO: implement rollDice
      throw UnimplementedError();
    }
  }
}
