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
