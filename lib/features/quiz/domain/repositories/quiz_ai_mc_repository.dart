import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';

abstract class QuizAIMCRepository {
  Future<Either<Failure, List<String>>> addSystemMessage(String message);

  Future<Either<Failure, Unit>> newMCSession();
}