import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:vou_games/features/quiz/domain/entities/player_answer_entity.dart';

import '../entities/quiz_connection_entity.dart';

abstract class QuizRepository {
  Future<Either<Failure, QuizConnectionEntity>> connectQuizGame(int gameId);

  Future<Either<Failure, Unit>> setRealTimeQuizListener(QuizRealTimeListener controller);

  Future<Either<Failure, Unit>> playerAnswerQuiz(int gameId, PlayerAnswerEntity ans);
}
