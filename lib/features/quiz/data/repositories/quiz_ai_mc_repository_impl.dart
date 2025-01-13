import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_ai_mc_datasource_contract.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_ai_mc_repository.dart';

class QuizAIMCRepositoryImpl implements QuizAIMCRepository {
  final NetworkInfo networkInfo;
  final QuizAIMCDataSource quizAIMCDataSource;

  QuizAIMCRepositoryImpl({required this.quizAIMCDataSource, required this.networkInfo});
}