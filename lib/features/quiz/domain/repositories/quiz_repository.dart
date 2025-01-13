import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';

import '../entities/quiz_connection_entity.dart';

abstract class QuizRepository {
  Future<Either<Failure, QuizConnectionEntity>> connectQuizGame(int gameId);

  Future<Either<Failure, Unit>> setRealTimeQuizController(QuizRealTimeListener controller);
}
