import 'package:flutter/material.dart';
import 'package:vou_games/configs/themes/custom_colors.dart';

class QuizLoadingView extends StatelessWidget {
  const QuizLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        color: CustomColors.semiTransparent,
        child: const Stack(children: [
          SizedBox(width: 252, height: 252, child: CircularProgressIndicator()),
          Text('Hang tight...')
        ]),
      ),
    );
  }
}
