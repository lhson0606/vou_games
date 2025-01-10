import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/games/domain/entities/game_types_string_entity.dart';
import 'package:vou_games/features/games/domain/repositories/game_repository.dart';

class GetCampaignGameTypesStringUseCase {
  final GameRepository gameRepository;

  GetCampaignGameTypesStringUseCase(this.gameRepository);

  Future<Either<Failure, GameTypesStringEntity>> call(int campaignId) async {
    return await gameRepository.getCampaignGameTypesString(campaignId);
  }
}