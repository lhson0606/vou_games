import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vou_games/features/dice/presentation/pages/dice_page.dart';

part 'dice_event.dart';
part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  DiceBloc() : super(DiceInitialState()) {
    on<DiceEvent>((event, emit) {
      if(event is PlayDiceEvent){
        emit(RequestNavigateToDiceState(DicePage(campaignId: event.campaignId)));
      }
    });
  }
}
