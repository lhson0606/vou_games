part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GetCampaignGamesEvent extends GameEvent {
  final int campaignId;

  const GetCampaignGamesEvent(this.campaignId);

  @override
  List<Object?> get props => [];
}
