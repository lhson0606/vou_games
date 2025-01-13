import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/images/app_images.dart';
import 'package:vou_games/configs/themes/custom_colors.dart';
import 'package:vou_games/core/utils/dialog/dialog_utils.dart';
import 'package:intl/intl.dart';
import 'package:vou_games/core/widgets/dialogues/confirm_dialogue.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_lobby_page.dart';

class QuizPage extends StatefulWidget {
  final int campaignId;
  final int gameId;
  final DateTime startAt;
  final DateTime joinAt;
  final DateTime waitAt;

  QuizPage({
    super.key,
    required this.campaignId,
    required this.gameId,
    required this.startAt,
  })  : joinAt = startAt.subtract(const Duration(minutes: 5)),
        waitAt = startAt.subtract(const Duration(minutes: 10));

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Timer _timer;
  late Duration timeLeftToJoin;
  bool joined = false;
  bool isConnecting = false;

  @override
  void initState() {
    super.initState();
    timeLeftToJoin = widget.joinAt.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          final now = DateTime.now();
          timeLeftToJoin = widget.joinAt.difference(now);
          if (timeLeftToJoin.isNegative) {
            timeLeftToJoin = Duration.zero;
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool canAutoJoin() {
    final now = DateTime.now();
    return now.isAfter(widget.waitAt) && now.isBefore(widget.startAt);
  }

  bool canJoinNow() {
    final now = DateTime.now();
    return now.isAfter(widget.joinAt) && now.isBefore(widget.startAt);
  }

  void autoJoin() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Timer? joiningAfterTimer;
            Duration timeLeft = widget.joinAt.difference(DateTime.now());

            void updateTimer() {
              final now = DateTime.now();
              if (now.isAfter(widget.joinAt)) {
                if (joiningAfterTimer != null) {
                  joiningAfterTimer.cancel();
                }
                performJoin();
                return;
              }
              setState(() {
                if (!mounted) return;

                timeLeft = widget.joinAt.difference(now);
                if (timeLeft.isNegative) {
                  timeLeft = Duration.zero;
                }
              });
            }

            joiningAfterTimer = Timer.periodic(
                const Duration(seconds: 1), (Timer t) => updateTimer());

            return AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(width: 16.0),
                  Text(
                    'Joining after ${timeLeft.isNegative ? '00:00' : '${timeLeft.inMinutes.toString().padLeft(2, '0')}:${(timeLeft.inSeconds % 60).toString().padLeft(2, '0')}'}',
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (joiningAfterTimer != null) {
                      joiningAfterTimer.cancel();
                    }
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void performJoin() {
    if (!canJoinNow()) {
      showMessageDialog(context, "The quiz is not available now!");
      return;
    }

    if (joined || isConnecting) {
      return;
    }

    isConnecting = true;

    context.read<QuizBloc>().add(JoinQuizEvent(gameId: widget.gameId));
  }

  void onJoinedQuizSuccess() {
    if (joined) {
      return;
    }

    joined = true;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizLobbyPage(
          startAt: widget.startAt,
          campaignId: widget.campaignId,
          gameId: widget.gameId,
        ),
      ),
    );
  }

  void onJoinedQuizFailed() {
    showSnackBar(context, "Failed to join the quiz", type: SnackBarType.error);

    // show rejoin dialog
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          message: "Failed to join the quiz. Do you want to try again?",
          onConfirm: () {
            // hide the dialog
            Navigator.of(context).pop();
            isConnecting = false;
            // perform join again after 1 second to prevent spamming
            Future.delayed(const Duration(seconds: 1), performJoin);
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeLeftToWait = widget.waitAt.difference(now);
    final timeLeftToStart = widget.startAt.difference(now);
    final dateFormat = DateFormat('yyyy-MM-dd \'at\' HH:mm:ss');

    return BlocListener<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is JoinQuizSuccessState) {
          onJoinedQuizSuccess();
        } else if (state is JoinQuizFailureState) {
          onJoinedQuizFailed();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quiz Page'),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.quizBg,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: CustomColors.semiTransparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Welcome! This is the Quiz Page. You can join in when the event starts!',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: CustomColors.semiTransparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                if (now.isBefore(widget.waitAt)) ...[
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          'The quiz will be opened to join on ',
                                      style: const TextStyle(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text:
                                              dateFormat.format(widget.joinAt),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                            text: ' and will end on '),
                                        TextSpan(
                                          text:
                                              dateFormat.format(widget.startAt),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(text: '.'),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ] else if (now.isBefore(widget.startAt)) ...[
                                  const Text(
                                    'You can click the "Start Quiz" button when the time left to wait is 00:00.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Time left to wait: ',
                                      style: const TextStyle(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: timeLeftToWait.isNegative
                                              ? '00:00'
                                              : '${timeLeftToWait.inMinutes.toString().padLeft(2, '0')}:${(timeLeftToWait.inSeconds % 60).toString().padLeft(2, '0')}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Time left to join: ',
                                      style: const TextStyle(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${timeLeftToStart.inMinutes.toString().padLeft(2, '0')}:${(timeLeftToStart.inSeconds % 60).toString().padLeft(2, '0')}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: canAutoJoin() ? autoJoin : null,
                                    child: const Text('Start Quiz'),
                                  ),
                                ] else ...[
                                  Text.rich(
                                    TextSpan(
                                      text: 'The quiz was started at ',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.red),
                                      children: [
                                        TextSpan(
                                          text:
                                              dateFormat.format(widget.startAt),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: null,
                                    child: const Text('Not Available'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: CustomColors.semiTransparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Setting',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: CustomColors.semiTransparent02,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.volume_up),
                                          SizedBox(width: 8.0),
                                          Text('Turn on sound'),
                                        ],
                                      ),
                                      Transform.scale(
                                        scale: 0.6,
                                        child: Switch(
                                          value: true,
                                          onChanged: (bool value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
