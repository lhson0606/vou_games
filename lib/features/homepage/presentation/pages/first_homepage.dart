import 'package:flutter/material.dart';

class FirstHomepage extends StatelessWidget {
  const FirstHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Homepage'),
      ),
      body: const Center(
        child: Text('Welcome to the First Homepage'),
      ),
    );
  }
}