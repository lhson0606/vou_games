import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable{
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final String status;
  final String location;

  const CampaignEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.location = "",
  });

  @override
  List<Object?> get props => [id];
}
