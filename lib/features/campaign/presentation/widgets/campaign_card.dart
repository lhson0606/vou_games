import 'package:flutter/material.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

class CampaignCard extends StatelessWidget {
  final CampaignEntity campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            campaign.imageUrl,
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              campaign.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Start: ${campaign.startDate}',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  'End: ${campaign.endDate}',
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    // Handle like button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}