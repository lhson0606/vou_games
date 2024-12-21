import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final String status;
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
    this.location = "",
    required this.gameTypes,
    required this.liked,
    required this.likesCount,
    required this.participantsCount,
  });

  @override
  List<Object?> get props => [id];
}
