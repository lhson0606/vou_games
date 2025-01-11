import 'package:vou_games/features/games/data/models/game_model.dart';

abstract class GameDataSource {
  Future<List<GameModel>> getCampaignGames(int campaignId);
}