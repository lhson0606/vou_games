part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable{}

class PlayQuizEvent extends QuizEvent {
  final int campaignId;
  final DateTime timeStamp = DateTime.now();

  PlayQuizEvent({required this.campaignId});

  @override
  List<Object?> get props => [campaignId, timeStamp];
}
