import 'package:vou_games/features/games/data/models/game_types_string_model.dart';

abstract class GameDataSource {
  Future<GameTypesStringModel> getCampaignGameTypesString(int campaignId);
}