part of 'game_bloc.dart';

abstract class GameState extends Equatable{}

final class GameInitial extends GameState {
  @override
  List<Object?> get props => [];
}

final class GameTypesStringLoadedState extends GameState {
  final int campaignId;
  final List<String> gameTypesString;

  GameTypesStringLoadedState({
    required this.campaignId,
    required this.gameTypesString,
  });

  @override
  List<Object?> get props => [campaignId, gameTypesString];
}

final class GameTypesStringLoadingState extends GameState {
  final int campaignId;

  GameTypesStringLoadingState({
    required this.campaignId,
  });

  @override
  List<Object?> get props => [campaignId];
}