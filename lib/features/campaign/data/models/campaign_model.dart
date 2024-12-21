import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  const CampaignModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.startDate,
    required super.endDate,
    required super.status,
    super.location,
    required super.gameTypes,
    required super.liked,
    required super.likesCount,
    required super.participantsCount,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      location: json['location'],
      gameTypes: List<String>.from(json['gameTypes']),
      liked: json['liked'],
      likesCount: json['likesCount'],
      participantsCount: json['participantsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'location': location,
      'gameTypes': gameTypes,
      'liked': liked,
      'likesCount': likesCount,
      'participantsCount': participantsCount,
    };
  }
}