import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/features/games/domain/usecases/get_campaign_game_types_string.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GetCampaignGameTypesStringUseCase getCampaignGameTypesStringUseCase;

  GameBloc({required this.getCampaignGameTypesStringUseCase}) : super(GameInitial()) {
    on<GameEvent>((event, emit) async {
      if(event is GetCampaignGameTypesStringEvent) {
        try {
          emit(GameTypesStringLoadingState(campaignId: event.campaignId));
          final failureOrGameTypesStringEntity = await getCampaignGameTypesStringUseCase(event.campaignId);
          failureOrGameTypesStringEntity.fold(
            (failure) => emit(GameTypesStringLoadedState(campaignId: event.campaignId, gameTypesString: const [])),
            (entity) => emit(GameTypesStringLoadedState(campaignId: event.campaignId, gameTypesString: entity.gameTypesString))
          );
        } catch (e) {
          emit(GameTypesStringLoadedState(campaignId: event.campaignId, gameTypesString: const []));
        }
      }
    });
  }
}
