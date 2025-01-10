import 'package:vou_games/features/games/data/datasources/game_data_source_contract.dart';
import 'package:vou_games/features/games/data/models/game_types_string_model.dart';

class GameHttpDataSource extends GameDataSource {
  @override
  Future<GameTypesStringModel> getCampaignGameTypesString(int campaignId) {
    // TODO: implement getCampaignGameTypesString
    throw UnimplementedError();
  }
}
