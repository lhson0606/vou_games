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
    };
  }
}