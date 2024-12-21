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