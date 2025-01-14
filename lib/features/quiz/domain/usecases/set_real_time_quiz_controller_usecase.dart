import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_repository.dart';

class SetRealTimeQuizControllerUseCase {
  final QuizRepository quizRepository;

  SetRealTimeQuizControllerUseCase({required this.quizRepository});

  Future<Either<Failure, Unit>> call(QuizRealTimeListener controller) {
    return quizRepository.setRealTimeQuizListener(controller);
  }
}