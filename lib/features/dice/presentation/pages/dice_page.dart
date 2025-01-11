import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vou_games/configs/lottie/app_lottie.dart';
import 'package:vou_games/features/dice/presentation/bloc/dice_bloc.dart';
import '../../../../core/widgets/dialogues/confirm_dialogue.dart';

class DicePage extends StatefulWidget {
  final int campaignId;
  final int gameId;
  const DicePage({super.key, required this.campaignId, required this.gameId});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with SingleTickerProviderStateMixin {
  bool _isSoundOn = true;
  bool _isShaking = false;
  int _diceValue = 1;
  int _attemptsLeft = 3;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    userAccelerometerEventStream().listen(
          (UserAccelerometerEvent event) {
        if (event.x.abs() > 2 || event.y.abs() > 2 || event.z.abs() > 2) {
          if (!_isShaking) {
            _isShaking = true;
            _rollDice();
          }
        } else {
          _isShaking = false;
        }
      },
      onError: (error) {
        _diceValue = Random().nextInt(6) + 1;
        _showResultDialog();
      },
      cancelOnError: true,
    );
  }

  void _rollDice() {
    setState(() {
      _diceValue = Random().nextInt(6) + 1;
      _attemptsLeft--;
    });
    Navigator.of(context).pop(); // Close the shake dialog
    _animationController.forward(from: 0).whenComplete(_callRollDice);
  }

  void _callRollDice() {
    context.read<DiceBloc>().add(StartRollingDiceEvent(widget.gameId));
  }

  void _showShakeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Let\'s roll the dice!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Shake your device to roll the dice or click the button below!',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Lottie.asset(
                AppLottie.shakePhone,
                height: 200,
                repeat: true,
                animate: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _rollDice,
                child: const Text('Roll dice'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset(
                AppLottie.celebration,
                fit: BoxFit.cover,
                repeat: true,
                animate: true,
              ),
            ),
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'You rolled a $_diceValue!',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          message: 'Are you sure you want to exit?',
          onConfirm: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dice'),
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
                                  Text(_isSoundOn ? 'Turn off sound' : 'Turn on sound'),
                                ],
                              ),
                              Transform.scale(
                                scale: 0.6,
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
                          const Divider(),
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
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Lottie.asset(
                AppLottie.diceRoll,
                width: 200,
                height: 200,
                repeat: true,
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController.duration = composition.duration;
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Attempts left: $_attemptsLeft',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _attemptsLeft > 0 ? _showShakeDialog : null,
                  child: const Text('Start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}