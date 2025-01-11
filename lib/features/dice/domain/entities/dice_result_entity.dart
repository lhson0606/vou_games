import 'package:equatable/equatable.dart';
import 'package:vou_games/core/common/data/entities/game_item_entity.dart';

class DiceResultEntity extends Equatable {
  final bool isPlayerWon;
  final GameItemEntity? reward;

  const DiceResultEntity({required this.isPlayerWon, this.reward});

  @override
  List<Object?> get props => [isPlayerWon, reward];
}
