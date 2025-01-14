import 'package:dartz/dartz.dart';
import 'package:vou_games/configs/policies/general_policies.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_ai_mc_datasource_contract.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_ai_mc_repository.dart';

class QuizAIMCRepositoryImpl implements QuizAIMCRepository {
  final NetworkInfo networkInfo;
  final QuizAIMCDataSource quizAIMCDataSource;

  QuizAIMCRepositoryImpl(
      {required this.quizAIMCDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<String>>> addSystemMessage(String message) async {
    if (await networkInfo.isConnected.timeout(
        const Duration(milliseconds: max_general_wait_time_ms),
        onTimeout: () => false)) {
      try {
        final messages = await quizAIMCDataSource.sendSystemMessage(message);
        return Right(messages);
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
  Future<Either<Failure, Unit>> newMCSession() async {
    try {
      quizAIMCDataSource.newSession();
      return const Right(unit);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
