part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable{}

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
