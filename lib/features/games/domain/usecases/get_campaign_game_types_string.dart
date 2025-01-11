import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/domain/repositories/game_repository.dart';

class GetCampaignGamesUseCase {
  final GameRepository gameRepository;

  GetCampaignGamesUseCase(this.gameRepository);

  Future<Either<Failure, List<GameEntity>>> call(int campaignId) async {
    return await gameRepository.getCampaignGames(campaignId);
  }
}