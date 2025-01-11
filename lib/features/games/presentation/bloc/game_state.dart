part of 'game_bloc.dart';

abstract class GameState extends Equatable{}

final class GameInitial extends GameState {
  @override
  List<Object?> get props => [];
}

final class CampaignGamesLoadedState extends GameState {
  final int campaignId;
  final List<GameEntity> games;

  CampaignGamesLoadedState({
    required this.campaignId,
    required this.games,
  });

  @override
  List<Object?> get props => [campaignId, games];
}

final class CampaignGamesLoadingState extends GameState {
  final int campaignId;

  CampaignGamesLoadingState({
    required this.campaignId,
  });

  @override
  List<Object?> get props => [campaignId];
}