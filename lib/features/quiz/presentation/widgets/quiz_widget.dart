import 'package:flutter/material.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';

class QuizWidget extends StatelessWidget {
  final QuizEntity quiz;

  const QuizWidget({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${quiz.questionNumber}: ${quiz.questionTitle}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(quiz.questionContent),
        const SizedBox(height: 16.0),
        Text('A. ${quiz.answerA}'),
        Text('B. ${quiz.answerB}'),
        Text('C. ${quiz.answerC}'),
        Text('D. ${quiz.answerD}'),
      ],
    );
  }
}
