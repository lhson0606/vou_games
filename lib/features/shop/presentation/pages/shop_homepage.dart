import 'package:flutter/material.dart';

class ShopHomepage extends StatelessWidget {
  const ShopHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Homepage'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Shop Homepage',
            ),
          ],
        ),
      ),
    );
  }
}