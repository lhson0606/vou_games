import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_in_game_page.dart';

class QuizLobbyPage extends StatefulWidget {
  final int campaignId;
  final int gameId;
  final DateTime startAt;

  const QuizLobbyPage(
      {super.key,
      required this.startAt,
      required this.campaignId,
      required this.gameId});

  @override
  _QuizLobbyPageState createState() => _QuizLobbyPageState();
}

class _QuizLobbyPageState extends State<QuizLobbyPage> {
  late Timer _timer;
  late Duration _timeLeft;
  bool _isTimeUp = false;
  bool _isFlashing = false;

  final List<String> randomJoinQuotes = ['Let\' rock and roll!', 'Let\'s get started!', 'Let\'s do this!', 'Let\'s get it on!', 'Let\'s get it started!', 'Let\'s get it poppin'];

  String get randomJoinQuote => randomJoinQuotes[DateTime.now().minute % randomJoinQuotes.length];

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.startAt.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft = widget.startAt.difference(DateTime.now());
        if (_timeLeft.isNegative) {
          _isTimeUp = true;
          _timer.cancel();
          _startFlashing();
        }
      });
    });
  }

  void _startFlashing() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isFlashing = !_isFlashing;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _isTimeUp
        ? '00:00'
        : '${_timeLeft.inMinutes.toString().padLeft(2, '0')}:${(_timeLeft.inSeconds % 60).toString().padLeft(2, '0')}';

    return BlocListener<QuizBloc, QuizState>(
  listener: (context, state) {
    if(state is QuizStartedState) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizInGamePage()));
    }
  },
  child: Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
                width: 252.0,
                height: 252.0,
                child: CircularProgressIndicator()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _isTimeUp
                        ? (_isFlashing ? Colors.red : Colors.transparent)
                        : Colors.black,
                  ),
                ),
                Text(randomJoinQuote),
              ],
            ),
          ],
        ),
      ),
    ),
);
  }
}
