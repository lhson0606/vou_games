import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/common/data/entities/game_item_entity.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/rank_entity.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/quiz/presentation/widgets/quiz_widget.dart';
import '../../../../core/widgets/dialogues/confirm_dialogue.dart';

class QuizInGamePage extends StatefulWidget {
  const QuizInGamePage({Key? key}) : super(key: key);

  @override
  _QuizInGamePageState createState() => _QuizInGamePageState();
}

class _QuizInGamePageState extends State<QuizInGamePage> {
  bool _isSoundOn = true;
  bool _isGameEnded = false;
  GameItemEntity? _reward;
  QuizEntity quiz = QuizEntity(
    questionNumber: -1,
    questionTitle: '',
    questionContent: '',
    answerA: '?',
    answerB: '?',
    answerC: '?',
    answerD: '?',
  );

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          message: 'Are you sure you want to exit?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pop(); // Exit the quiz page
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  void _showCongratulationDialog(GameItemEntity? reward) {
    if (reward == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(reward.getDisplayImageUrl()),
              const SizedBox(height: 16.0),
              Text(
                reward.getDisplayName(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                reward.getDisplayDescription(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showQuitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          message: 'Are you sure you want to quit?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pop(); // Exit the quiz page
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  void _showQuizRank(RankEntity rank) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Ended'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your rank: ${rank.rank}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Your score: ${rank.totalScore}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Total time: ${rank.totalTime}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if(_reward != null) {
                  _showCongratulationDialog(_reward);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
  listener: (context, state) {
    if(state is QuizErrorState) {
      showSnackBar(context, state.message, type: SnackBarType.error);
    } else if (state is NewQuizState) {
      setState(() {
        quiz = state.quiz;
      });
    } else if(state is QuizEndedState) {
      setState(() {
        _isGameEnded = true;
      });
    } else if (state is QuizRewardState) {
      setState(() {
        _reward = state.reward;
      });
    } else if (state is SystemMessageState) {
      showSnackBar(context, state.message, type: SnackBarType.info);
    } else if(state is QuizRankingState) {
      _showQuizRank(state.rank);
    }
  },
  builder: (context, state) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz In Game'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(_isSoundOn ? Icons.volume_up : Icons.volume_off),
                                  const SizedBox(width: 8.0),
                                  Text('Turn on sound'),
                                ],
                              ),
                              Transform.scale(
                                scale: 0.6, // Adjust the scale to make the switch smaller
                                child: Switch(
                                  value: _isSoundOn,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isSoundOn = value;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(), // Add a horizontal line
                          ListTile(
                            leading: const Icon(Icons.exit_to_app),
                            title: const Text('Exit'),
                            onTap: _showConfirmDialog,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // if state is QuizEndedState, show the quit button
            if (_isGameEnded)
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: _showQuitConfirmationDialog,
              ),
          ],
        ),
        body: QuizWidget(quiz: quiz),
      ),
    );
  },
);
  }
}