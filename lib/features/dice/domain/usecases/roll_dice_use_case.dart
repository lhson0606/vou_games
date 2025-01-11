import 'package:dartz/dartz.dart';
import 'package:vou_games/features/dice/domain/repositories/dice_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/dice_result_entity.dart';

class RollDiceUseCase {
  final DiceRepository diceRepository;

  RollDiceUseCase(this.diceRepository);

  Future<Either<Failure, DiceResultEntity>> call(int gameId) async {
    return diceRepository.rollDice(gameId);
  }
}