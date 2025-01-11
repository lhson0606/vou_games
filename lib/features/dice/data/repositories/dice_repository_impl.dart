import 'package:dartz/dartz.dart';
import 'package:vou_games/configs/policies/general_policies.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/dice/data/datasources/dice_remote_data_source_contract.dart';
import 'package:vou_games/features/dice/domain/entities/dice_result_entity.dart';
import 'package:vou_games/features/dice/domain/repositories/dice_repository.dart';

class DiceRepositoryImpl implements DiceRepository {
  final DiceDataSource diceDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferencesService sharedPreferencesService;
  final UserCredentialService userCredentialService;

  DiceRepositoryImpl(
      {required this.diceDataSource,
      required this.networkInfo,
      required this.sharedPreferencesService,
      required this.userCredentialService});

  @override
  Future<Either<Failure, DiceResultEntity>> rollDice(int gameId) async {
    if (await networkInfo.isConnected
        .timeout(const Duration(milliseconds: max_general_wait_time_ms), onTimeout: () => false)) {
      try {
        final diceResult = await diceDataSource.rollDice(gameId);
        return Right(diceResult);
      } on ExceptionWithMessage catch (e) {
        return Left(FailureWithMessage(message: e.message));
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
