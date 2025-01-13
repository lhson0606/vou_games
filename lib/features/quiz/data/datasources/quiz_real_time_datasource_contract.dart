import 'package:vou_games/features/quiz/data/models/quiz_connection_model.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';

abstract class QuizRealTimeDataSource {
  Future<QuizConnectionModel> connectQuizGame(int gameId, String token);

  void setController(QuizRealTimeListener controller);

  void closeConnection();
}
