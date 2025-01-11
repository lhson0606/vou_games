import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou_games/configs/games/game_type.dart';
import 'package:vou_games/core/builders/url/url_builder.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/network/result_message.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/core/utils/strings/string_utils.dart';
import 'package:vou_games/features/games/data/datasources/game_data_source_contract.dart';
import 'package:vou_games/features/games/data/models/game_model.dart';
import 'package:vou_games/features/games/data/models/game_type_model.dart';
import 'package:vou_games/features/games/data/models/game_types_string_model.dart';
import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:http/http.dart' as http;

class GameHttpDataSource extends GameDataSource {
  UserCredentialService userCredentialService;

  GameHttpDataSource({required this.userCredentialService});

  @override
  Future<GameTypesStringModel> getCampaignGameTypesString(
      int campaignId) async {
    if (!userCredentialService.isLoggedIn) {
      throw NoUserException();
    }

    final url = UrlBuilderFactory.createCampaignGameUrlBuilder()
        .campaignId(campaignId)
        .build();

    http.Response response;

    try {
      response = await http.get(
          headers: config.getAuthorizedHeaders(userCredentialService.userToken),
          url);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200) {
      throw ServerException();
    }

    try {
      ResultMessage res = ResultMessage.fromResponse(response);

      if (res.status == 200 || res.status == 201) {
        List<dynamic> games = res.data as List<dynamic>;

        if (games.isEmpty) {
          return GameTypesStringModel(
              campaignId: campaignId, gameTypesString: const []);
        }

        Set<String> gameTypesString = {};

        for (var game in games) {
          try {
            GameModel gameModel = GameModel.fromJson(game);

            if (gameModel.gameType.name.toLowerCase().contains("shake")) {
              gameTypesString.add(roll_dice_string);
            } else if (gameModel.gameType.name.toLowerCase().contains("quiz")) {
              gameTypesString.add(real_time_quiz_string);
            }
          } catch (e) {
            final details = FlutterErrorDetails(exception: e);
            FlutterError.dumpErrorToConsole(details);
            //ignore
          }
        }

        return GameTypesStringModel(
            campaignId: campaignId, gameTypesString: gameTypesString.toList());
      }
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
    }

    throw ServerException();
  }
}
