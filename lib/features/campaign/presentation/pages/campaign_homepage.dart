import 'package:flutter/material.dart';

class CampaignHomePage extends StatelessWidget {
  const CampaignHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign'),
      ),
      body: const Center(
        child: Text('Campaign Home Page'),
      ),
    );
  }
}