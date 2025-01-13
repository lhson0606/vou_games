part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {}

class PlayQuizEvent extends QuizEvent {
  final int campaignId;
  final int gameId;
  final DateTime startAt;

  PlayQuizEvent(
      {required this.campaignId, required this.gameId, required this.startAt});

  @override
  List<Object?> get props => [campaignId, gameId, startAt, startAt];
}

class JoinQuizEvent extends QuizEvent {
  final int gameId;

  JoinQuizEvent({required this.gameId});

  @override
  List<Object?> get props => [gameId];
}

class ControllerSystemMessageEvent extends QuizEvent {
  final String message;

  ControllerSystemMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ControllerNewQuizQuestionEvent extends QuizEvent {
  final QuizEntity quiz;

  ControllerNewQuizQuestionEvent({required this.quiz});

  @override
  List<Object?> get props => [quiz];
}

class ControllerQuizEndedEvent extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class ControllerQuizSolutionEvent extends QuizEvent {
  final SolutionEntity solution;

  ControllerQuizSolutionEvent({required this.solution});

  @override
  List<Object?> get props => [solution];
}

class ControllerQuizStartedEvent extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class ControllerQuizRankingEvent extends QuizEvent {
  final RankEntity rank;

  ControllerQuizRankingEvent({required this.rank});

  @override
  List<Object?> get props => [rank];
}

class ControllerQuizRewardEvent extends QuizEvent {
  final GameItemEntity reward;

  ControllerQuizRewardEvent({required this.reward});

  @override
  List<Object?> get props => [reward];
}

class ControllerTimeRemainingEvent extends QuizEvent {
  final int timeRemaining;
  ControllerTimeRemainingEvent({required this.timeRemaining});

  @override
  List<Object?> get props => [timeRemaining];
}

class ControllerQuizErrorEvent extends QuizEvent {
  final String message;

  ControllerQuizErrorEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class QuizAnswerEvent extends QuizEvent {
  final String answer;

  QuizAnswerEvent({required this.answer});

  @override
  List<Object?> get props => [answer];
}