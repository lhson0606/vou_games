import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final int campaignId;
  const QuizPage({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Quiz Page'),
      ),
    );
  }
}