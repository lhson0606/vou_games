part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GetCampaignGameTypesStringEvent extends GameEvent {
  final int campaignId;

  const GetCampaignGameTypesStringEvent(this.campaignId);

  @override
  List<Object?> get props => [];
}
