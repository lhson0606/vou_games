import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';

import 'quiz_connection_model.dart';

class WSQuizConnectionModel extends QuizConnectionModel {
  const WSQuizConnectionModel({required super.isConnected});

  @override
  void setQuizRealTimeController(QuizRealTimeListener controller) {
    // subclass implementation
  }
}