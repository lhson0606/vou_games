part of 'dice_bloc.dart';

abstract class DiceState extends Equatable{}

final class DiceInitialState extends DiceState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToDiceState extends DiceState {
  final Widget dicePage;
  final DateTime timeStamp = DateTime.now();

  RequestNavigateToDiceState(this.dicePage);

  @override
  List<Object?> get props => [dicePage, timeStamp];
}

final class DiceRollingState extends DiceState {
  final DateTime timeStamp = DateTime.now();

  @override
  List<Object?> get props => [timeStamp];
}

final class DiceRolledState extends DiceState {
  final DiceResultEntity diceResult;
  final DateTime timeStamp = DateTime.now();

  DiceRolledState({required this.diceResult});

  @override
  List<Object?> get props => [diceResult, timeStamp];
}

final class DiceRollFailedState extends DiceState {
  final String message;

  DiceRollFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}