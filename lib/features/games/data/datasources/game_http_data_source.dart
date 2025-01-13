import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/builders/url/http_url_builder.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/network/result_message.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/games/data/datasources/game_data_source_contract.dart';
import 'package:vou_games/features/games/data/models/game_model.dart';
import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:http/http.dart' as http;

class GameHttpDataSource extends GameDataSource {
  UserCredentialService userCredentialService;

  GameHttpDataSource({required this.userCredentialService});

  @override
  Future<List<GameModel>> getCampaignGames(
      int campaignId) async {
    if (!userCredentialService.isLoggedIn) {
      throw NoUserException();
    }

    final url = HttpUrlBuilderFactory.createCampaignGameUrlBuilder()
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
          return [];
        }

        List<GameModel> gamesList = [];

        for (var game in games) {
          try {
            GameModel gameModel = GameModel.fromJson(game);
            gamesList.add(gameModel);
          } catch (e) {
            final details = FlutterErrorDetails(exception: e);
            FlutterError.dumpErrorToConsole(details);
            //ignore
          }
        }

        return gamesList;
      }
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
    }

    throw ServerException();
  }
}
