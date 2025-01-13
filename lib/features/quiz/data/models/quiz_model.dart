import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel(
      {required super.questionNumber,
      required super.questionTitle,
      required super.questionContent,
      required super.answerA,
      required super.answerB,
      required super.answerC,
      required super.answerD});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questionNumber: json['questionNumber'],
      questionTitle: json['questionTitle'],
      questionContent: json['questionContent'],
      answerA: json['answerA'],
      answerB: json['answerB'],
      answerC: json['answerC'],
      answerD: json['answerD'],
    );
  }
}
