import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_ai_mc_repository.dart';

class NewMCSessionUseCase {
  final QuizAIMCRepository quizRepository;

  NewMCSessionUseCase({required this.quizRepository});

  Future<Either<Failure, Unit>> call() async {
    return quizRepository.newMCSession();
  }
}
