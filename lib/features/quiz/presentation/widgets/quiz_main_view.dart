import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/quiz/domain/entities/player_answer_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/quiz/presentation/widgets/player_waiting_for_answer_view.dart';
import 'package:vou_games/features/quiz/presentation/widgets/quiz_loading_view.dart';
import 'package:vou_games/features/quiz/presentation/widgets/quiz_solution_view.dart';

class QuizMainView extends StatefulWidget {
  final int gameId;

  const QuizMainView({super.key, required this.gameId});

  @override
  _QuizMainViewState createState() => _QuizMainViewState();
}

class _QuizMainViewState extends State<QuizMainView> {
  int timeLeft = 0;
  String userAnswer = '';
  bool userAnswered = false;
  QuizEntity currentQuiz = QuizEntity(
    questionNumber: 0,
    questionTitle: '',
    answerA: '',
    answerB: '',
    answerC: '',
    answerD: '',
    questionContent: '',
  );

  String getUserAnswerContent(String answer, QuizEntity quiz) {
    if (answer == 'A') {
      return quiz.answerA;
    } else if (answer == 'B') {
      return quiz.answerB;
    } else if (answer == 'C') {
      return quiz.answerC;
    } else if (answer == 'D') {
      return quiz.answerD;
    } else {
      return '';
    }
  }

  void chooseSelectedAnswer(String answer) {
    if (userAnswered) return;

    PlayerAnswerEntity answerEntity = PlayerAnswerEntity(
        questionNumber: currentQuiz.questionNumber, answer: answer);
    context.read<QuizBloc>().add(
        PlayerAnswerQuizEvent(gameId: widget.gameId, answer: answerEntity));
  }

  void onPlayerAnswerCorrect() =>
      showSnackBar(context, 'Correct answer!', type: SnackBarType.success);

  void onPlayerAnswerWrong() =>
      showSnackBar(context, 'Wrong answer!', type: SnackBarType.error);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(buildWhen: (previous, current) {
      return current is QuizStartedState ||
          current is NewQuizState ||
          current is PlayerAnswerSuccessState ||
          current is ShowQuizSolutionState ||
          current is QuizEndedState;
    }, listenWhen: (previous, current) {
      return current is TimeRemainingState ||
          current is NewQuizState ||
          current is ShowQuizSolutionState ||
          current is PlayerAnswerSuccessState ||
          current is QuizEndedState;
    }, listener: (context, state) {
      if (state is TimeRemainingState) {
        setState(() {
          timeLeft = state.timeRemaining;
        });
      } else if (state is NewQuizState) {
        setState(() {
          userAnswer = '';
          currentQuiz = state.quiz;
          timeLeft = 0;
        });
        userAnswered = false;
      } else if (state is ShowQuizSolutionState) {
        if (userAnswer == state.ans.correctAnswer) {
          onPlayerAnswerCorrect();
        } else {
          onPlayerAnswerWrong();
        }
      } else if (state is PlayerAnswerSuccessState) {
        setState(() {
          userAnswer = state.answer.answer;
        });

        userAnswered = true;
      }
    }, builder: (context, state) {
      if (state is QuizEndedState) {
        return Center(
          child: Column(
            children: [
              const Text('Quiz ended!'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      } else if (state is PlayerAnswerSuccessState) {
        return Center(child: PlayerWaitingForAnswerView());
      } else if (state is QuizStartedState) {
        return Center(child: const QuizLoadingView());
      } else if (state is NewQuizState) {
        return Center(
          child: Column(
            children: [
              // First half: Question
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quest ${state.quiz.questionNumber}',
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
                        state.quiz.questionTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // const SizedBox(height: 16.0),
                      // // Optional image
                      // Image.asset(
                      //   'assets/question_image.png',
                      //   height: 150,
                      //   fit: BoxFit.cover,
                      // ),
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
                          state.quiz.answerA,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
                          state.quiz.answerB,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
                          state.quiz.answerC,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
                          state.quiz.answerD,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (state is ShowQuizSolutionState) {
        return Center(
          child: QuizSolutionView(
              question: currentQuiz.questionTitle,
              correctAnswer:
                  "${state.ans.correctAnswer}. ${getUserAnswerContent(state.ans.correctAnswer, currentQuiz)}",
              explanation: state.ans.answerExplanation),
        );
      }

      return Center(child: const QuizLoadingView());
    });
  }
}
