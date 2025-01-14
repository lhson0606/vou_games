import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vou_games/configs/themes/custom_colors.dart';

class PlayerWaitingForAnswerView extends StatefulWidget {
  PlayerWaitingForAnswerView({super.key}) {}

  @override
  State<PlayerWaitingForAnswerView> createState() =>
      _PlayerWaitingForAnswerViewState();
}

class _PlayerWaitingForAnswerViewState
    extends State<PlayerWaitingForAnswerView> {
  String randomQuote = "";
  final List<String> allQuotes = [
    'Lightning fast?',
    "Pure genius!?",
    "You're on fire!?",
    "You're a wizard!?",
    "You're a genius!?",
    "You're a legend!?",
    "You're a master"
  ];

  @override
  void initState() {
    super.initState();
    randomQuote = allQuotes[Random().nextInt(allQuotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        color: CustomColors.semiTransparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              randomQuote,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
