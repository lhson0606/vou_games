import 'package:flutter/material.dart';
import 'package:vou_games/configs/themes/custom_colors.dart';

class QuizSolutionView extends StatelessWidget {
  final String question;
  final String correctAnswer;
  final String explanation;

  const QuizSolutionView({
    super.key,
    required this.question,
    required this.correctAnswer,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        color: CustomColors.semiTransparent,
        child: Column(
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              correctAnswer,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              explanation,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
