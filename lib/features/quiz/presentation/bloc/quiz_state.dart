part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {}

final class QuizInitialState extends QuizState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToQuizState extends QuizState {
  final Widget quizPage;
  final DateTime timeStamp = DateTime.now();

  RequestNavigateToQuizState(this.quizPage);

  @override
  List<Object?> get props => [quizPage, timeStamp];
}

final class JoinQuizSuccessState extends QuizState {
  @override
  List<Object?> get props => [];
}

final class JoinQuizFailureState extends QuizState {
  final String message;

  JoinQuizFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class QuizStartedState extends QuizState {
  @override
  List<Object?> get props => [];
}

final class NewQuizState extends QuizState {
  final QuizEntity quiz;

  NewQuizState({required this.quiz});

  @override
  List<Object?> get props => [quiz];
}

final class ShowQuizSolutionState extends QuizState {
  final SolutionEntity ans;

  ShowQuizSolutionState({required this.ans});

  @override
  List<Object?> get props => [ans];
}

final class ShowQuizResultState extends QuizState {
  final RankEntity rank;

  ShowQuizResultState({required this.rank});

  @override
  List<Object?> get props => [rank];
}

final class ShowQuizRewardState extends QuizState {
  final GameItemEntity reward;

  ShowQuizRewardState({required this.reward});

  @override
  List<Object?> get props => [reward];
}

final class QuizEndedState extends QuizState {
  @override
  List<Object?> get props => [];
}

final class TimeRemainingState extends QuizState {
  final int timeRemaining;

  TimeRemainingState({required this.timeRemaining});

  @override
  List<Object?> get props => [timeRemaining];
}

final class QuizErrorState extends QuizState {
  final String message;

  QuizErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class SystemMessageState extends QuizState {
  final String message;

  SystemMessageState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class QuizRankingState extends QuizState {
  final RankEntity rank;

  QuizRankingState({required this.rank});

  @override
  List<Object?> get props => [rank];
}

final class QuizRewardState extends QuizState {
  final GameItemEntity reward;

  QuizRewardState({required this.reward});

  @override
  List<Object?> get props => [reward];
}

final class PlayerAnswerSuccessState extends QuizState {
  final int gameId;
  final PlayerAnswerEntity answer;

  PlayerAnswerSuccessState({required this.gameId, required this.answer});

  @override
  List<Object?> get props => [gameId, answer];
}

final class AIMCSpeakingState extends QuizState {
  final DateTime timeStamp = DateTime.now();

  @override
  List<Object?> get props => [timeStamp];
}

final class AIMcStopSpeakingState extends QuizState {
  final DateTime timeStamp = DateTime.now();

  @override
  List<Object?> get props => [timeStamp];
}
