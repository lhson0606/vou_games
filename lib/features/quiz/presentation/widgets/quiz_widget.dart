import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';

class QuizWidget extends StatefulWidget {
  final QuizEntity quiz;

  const QuizWidget({super.key, required this.quiz});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int timeLeft = 0;
  String userAnswer = '';

  void chooseSelectedAnswer(String answer) {
    setState(() {
      userAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is TimeRemainingState) {
          setState(() {
            timeLeft = state.timeRemaining;
          });
        } else if (state is NewQuizState) {
          setState(() {
            userAnswer = '';
          });
        } else if (state is ShowQuizSolutionState) {
          if (userAnswer == state.ans.correctAnswer) {
            showSnackBar(context, 'Correct answer!',
                type: SnackBarType.success);
          } else {
            showSnackBar(context, 'Wrong answer!', type: SnackBarType.error);
          }
        }
      },
      child: Center(
        child: Column(
          children: [
            // First half: Question
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quest ${widget.quiz.questionNumber}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Time left: 0${timeLeft}s',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.quiz.questionTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    // Optional image
                    Image.asset(
                      'assets/question_image.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            // Second half: Options
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        chooseSelectedAnswer('A');
                      },
                      child: Text(
                        widget.quiz.answerA,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        chooseSelectedAnswer('B');
                      },
                      child: Text(
                        widget.quiz.answerB,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        chooseSelectedAnswer('C');
                      },
                      child: Text(
                        widget.quiz.answerC,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        chooseSelectedAnswer('D');
                      },
                      child: Text(
                        widget.quiz.answerD,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
