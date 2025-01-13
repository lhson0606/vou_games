import 'package:dartz/dartz.dart';
import 'package:vou_games/configs/policies/general_policies.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_connection_entity.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_repository.dart';

import '../datasources/quiz_datasource_contract.dart';
import '../datasources/quiz_real_time_datasource_contract.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource quizDataSource;
  final QuizRealTimeDataSource quizRealTimeDataSource;
  final NetworkInfo networkInfo;
  final UserCredentialService userCredentialService;

  QuizRepositoryImpl({
    required this.networkInfo,
    required this.quizDataSource,
    required this.quizRealTimeDataSource,
    required this.userCredentialService,
  });

  @override
  Future<Either<Failure, QuizConnectionEntity>> connectQuizGame(
      int gameId) async {

    if(!userCredentialService.isLoggedIn) {
      return Left(NoUserFailure());
    }

    if (await networkInfo.isConnected
        .timeout(const Duration(milliseconds: max_general_wait_time_ms),
        onTimeout: () => false)) {
      try {
        final token = userCredentialService.userToken;
        if (token == null) {
          return Left(NoUserFailure());
        }
        final con = await quizRealTimeDataSource.connectQuizGame(gameId, token);
        return Right(con);
      } on ExceptionWithMessage catch (e) {
        return Left(FailureWithMessage(message: e.message));
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setRealTimeQuizController(QuizRealTimeListener controller) {
    try {
      quizRealTimeDataSource.setController(controller);
      return Future.value(const Right(unit));
    } on ExceptionWithMessage catch (e) {
      return Future.value(Left(FailureWithMessage(message: e.message)));
    } on Exception {
      return Future.value(Left(UnknownFailure()));
    }
  }
}
