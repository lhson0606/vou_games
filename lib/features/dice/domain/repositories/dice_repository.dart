import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/dice/domain/entities/dice_result_entity.dart';

abstract class DiceRepository {
  Future<Either<Failure, DiceResultEntity>> rollDice(int gameId);
}