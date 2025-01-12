import 'package:vou_games/core/common/data/models/reward_piece_model.dart';
import 'package:vou_games/core/common/data/models/reward_voucher_model.dart';
import 'package:vou_games/features/dice/domain/entities/dice_result_entity.dart';

class DiceResultModel extends DiceResultEntity {
  const DiceResultModel({required super.isPlayerWon, required super.reward});

  DiceResultModel.voucherReward({required bool isPlayerWin, required RewardVoucherModel reward})
      : super(reward: reward, isPlayerWon: isPlayerWin);

  DiceResultModel.pieceReward({required bool isPlayerWin, required RewardPieceModel reward})
      : super(reward: reward, isPlayerWon: isPlayerWin);
}
