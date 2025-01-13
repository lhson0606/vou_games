import 'package:equatable/equatable.dart';

class QuizEntity extends Equatable {
  final int questionNumber;
  final String questionTitle;
  final String questionContent;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;

  QuizEntity({
    required this.questionNumber,
    required this.questionTitle,
    required this.questionContent,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
  });

  @override
  List<Object?> get props => [
        questionNumber,
        questionTitle,
        questionContent,
        answerA,
        answerB,
        answerC,
        answerD,
      ];
}
