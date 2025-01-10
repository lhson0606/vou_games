import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity implements JsonModel{
  const CampaignModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.startDate,
    required super.endDate,
    required super.status,
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
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJsonString
    throw UnimplementedError();
  }

  @override
  String toJsonString() {
    // TODO: implement toJsonString
    throw UnimplementedError();
  }
}