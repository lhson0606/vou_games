import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/dice/domain/entities/dice_result_entity.dart';
import 'package:vou_games/features/dice/domain/usecases/roll_dice_use_case.dart';
import 'package:vou_games/features/dice/presentation/pages/dice_page.dart';

part 'dice_event.dart';

part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  RollDiceUseCase rollDiceUseCase;

  DiceBloc({required this.rollDiceUseCase}) : super(DiceInitialState()) {
    on<DiceEvent>((event, emit) async {
      if (event is PlayDiceEvent) {
        emit(RequestNavigateToDiceState(
            DicePage(campaignId: event.campaignId, gameId: event.gameId)));
      } else if (event is StartRollingDiceEvent) {
        emit(DiceRollingState());
        final failureOrDiceResult = await rollDiceUseCase.call(event.gameId);
        failureOrDiceResult.fold(
          (failure) => emit(DiceRollFailedState(message: failureToErrorMessage(failure))),
          (diceResult) => emit(DiceRolledState(diceResult: diceResult)),
        );
      }
    });
  }
}
