import 'package:vou_games/features/quiz/domain/entities/solution_entity.dart';

class SolutionModel extends SolutionEntity {
  SolutionModel(
      {required super.questionNumber,
      required super.correctAnswer,
      required super.answerExplanation});

  factory SolutionModel.fromJson(Map<String, dynamic> json) {
    return SolutionModel(
      questionNumber: json['questionNumber'],
      correctAnswer: json['correctAnswer'],
      answerExplanation: json['answerExplanation'],
    );
  }
}
