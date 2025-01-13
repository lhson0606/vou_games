import 'package:equatable/equatable.dart';
import 'package:vou_games/core/common/data/entities/game_item_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/rank_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/solution_entity.dart';

abstract class QuizRealTimeListener extends Equatable {
  void onSystemMessage(String message);
  void onTimeRemaining(int timeRemaining);
  void onQuizStarted();
  void onNewQuizQuestion(QuizEntity quiz);
  void onQuizQuestionAnswered(SolutionEntity ans);
  void onQuizRanking(RankEntity rank);
  void onQuizReward(GameItemEntity? reward);
  void onError(String welcomeMessage);
  void onPing();
  void onQuizEnded();

}