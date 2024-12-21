import 'package:flutter/material.dart';

class DicePage extends StatelessWidget {
  final int campaignId;
  const DicePage({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Dice(),
            Text('Welcome to the Dice Page'),
          ],
        ),
      ),
    );
  }
}