import 'package:flutter/material.dart';
import 'package:vou_games/configs/images/app_images.dart';
import 'package:vou_games/configs/themes/custom_colors.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_in_game_page.dart';

class QuizPage extends StatelessWidget {
  final int campaignId;

  const QuizPage({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: CustomColors.semiTransparent,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.volume_up),
                                    const SizedBox(width: 8.0),
                                    const Text('Turn on sound'),
                                  ],
                                ),
                                Transform.scale(
                                  scale: 0.6, // Adjust the scale to make the switch smaller
                                  child: Switch(
                                    value: true,
                                    onChanged: (bool value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: CustomColors.semiTransparent02,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Well come! This is the Quiz Page. You can join in when the event starts!.',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to QuizInGamePage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizInGamePage(),
                                ),
                              );
                            },
                            child: const Text('Start Quiz'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}