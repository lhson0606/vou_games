import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/entities/player_answer_entity.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_repository.dart';

class PlayerAnswerQuizUseCase {
  final QuizRepository quizRepository;

  PlayerAnswerQuizUseCase({required this.quizRepository});

  Future<Either<Failure, Unit>> call(int gameId, PlayerAnswerEntity ans) {
    return quizRepository.playerAnswerQuiz(gameId, ans);
  }
}