import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';

abstract class GameRepository {
  Future<Either<Failure, List<GameEntity>>> getCampaignGames(int campaignId);
}