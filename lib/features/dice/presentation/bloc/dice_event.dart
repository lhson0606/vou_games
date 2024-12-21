part of 'dice_bloc.dart';

abstract class DiceEvent extends Equatable{}

class PlayDiceEvent extends DiceEvent {
  final int campaignId;
  final DateTime timeStamp = DateTime.now();

  PlayDiceEvent({required this.campaignId});

  @override
  List<Object?> get props => [campaignId, timeStamp];
}