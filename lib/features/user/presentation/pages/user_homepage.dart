import 'package:flutter/material.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Homepage'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the User Homepage',
            ),
          ],
        ),
      ),
    );
  }
}