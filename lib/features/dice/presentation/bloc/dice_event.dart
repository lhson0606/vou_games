part of 'dice_bloc.dart';

abstract class DiceEvent extends Equatable {}

class PlayDiceEvent extends DiceEvent {
  final int campaignId;
  final int gameId;
  final DateTime timeStamp = DateTime.now();

  PlayDiceEvent({required this.campaignId, required this.gameId});

  @override
  List<Object?> get props => [campaignId, timeStamp];
}

class StartRollingDiceEvent extends DiceEvent {
  final int gameId;
  final DateTime timeStamp = DateTime.now();

  StartRollingDiceEvent(this.gameId);

  @override
  List<Object?> get props => [timeStamp, gameId];
}
