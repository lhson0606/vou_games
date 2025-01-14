import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_ai_mc_repository.dart';

class InformAiMcUseCase {
  final QuizAIMCRepository quizAIMCRepository;

  InformAiMcUseCase({required this.quizAIMCRepository});

  Future<Either<Failure, List<String>>> call(String message) {
    return quizAIMCRepository.addSystemMessage(message);
  }
}