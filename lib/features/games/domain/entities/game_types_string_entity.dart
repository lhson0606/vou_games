import 'package:equatable/equatable.dart';

class GameTypesStringEntity extends Equatable {
  final int campaignId;
  final List<String> gameTypesString;

  const GameTypesStringEntity({
    required this.campaignId,
    required this.gameTypesString,
  });

  @override
  List<Object?> get props => [campaignId, gameTypesString];
}