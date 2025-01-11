import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/games/data/datasources/game_data_source_contract.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameDataSource dataSource;
  final NetworkInfo networkInfo;
  final UserCredentialService userCredentialService;

  GameRepositoryImpl({required this.dataSource, required this.networkInfo, required this.userCredentialService});

  @override
  Future<Either<Failure, List<GameEntity>>> getCampaignGames(int campaignId) async {

    if (await networkInfo.isConnected
      .timeout(const Duration(seconds: 10), onTimeout: () => false)
    ) {
      try {
        final games = await dataSource.getCampaignGames(campaignId);
        return Right(games);
      } catch (e) {
        return Right([]);
      }
    } else {
      return Right([]);
    }
  }
}