import 'package:flutter/material.dart';

class NotificationHomepage extends StatelessWidget {
  const NotificationHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: const Center(
        child: Text('Notification Homepage'),
      ),
    );
  }
}