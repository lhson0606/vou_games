import 'package:vou_games/features/dice/data/models/dice_result_model.dart';

abstract class DiceDataSource {
  Future<DiceResultModel> rollDice(int gameId);
}