import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final String status;
  final int? brandId;
  final String location;
  final List<String> gameTypes;
  final bool liked;
  final int likesCount;
  final int participantsCount;

  const CampaignEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.brandId,
    this.location = "",
    this.gameTypes = const [],
    this.liked = false,
    this.likesCount = 0,
    this.participantsCount = 0,
  });

  @override
  List<Object?> get props => [id];
}
