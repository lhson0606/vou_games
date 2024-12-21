part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable{}

class PlayQuizEvent extends QuizEvent {
  final int campaignId;
  final String gameType;
  final DateTime timeStamp = DateTime.now();

  PlayQuizEvent({required this.campaignId, required this.gameType});

  @override
  List<Object?> get props => [campaignId, gameType, timeStamp];
}
