import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_connection_entity.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_repository.dart';

class ConnectQuizGameUseCase {
  final QuizRepository quizRepository;

  ConnectQuizGameUseCase({required this.quizRepository});

  Future<Either<Failure, QuizConnectionEntity>> call(int gameId) async {
    return quizRepository.connectQuizGame(gameId);
  }
}