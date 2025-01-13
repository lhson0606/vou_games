import 'package:equatable/equatable.dart';

class SolutionEntity extends Equatable{
  final int questionNumber;
  final String correctAnswer;
  final String answerExplanation;

  const SolutionEntity({
    required this.questionNumber,
    required this.correctAnswer,
    required this.answerExplanation,
  });

  @override
  List<Object?> get props => [questionNumber];
}
