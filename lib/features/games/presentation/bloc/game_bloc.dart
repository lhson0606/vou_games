import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/domain/entities/game_type_entity.dart';
import 'package:vou_games/features/games/domain/usecases/get_campaign_game_types_string.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GetCampaignGamesUseCase getCampaignGamesUseCase;

  GameBloc({required this.getCampaignGamesUseCase}) : super(GameInitial()) {
    on<GameEvent>((event, emit) async {
      if(event is GetCampaignGameTypesStringEvent) {
        try {
          emit(CampaignGamesLoadingState(campaignId: event.campaignId));
          final failureOrGamesEntity = await getCampaignGamesUseCase(event.campaignId);
          failureOrGamesEntity.fold(
            (failure) => emit(CampaignGamesLoadedState(campaignId: event.campaignId, games: const [])),
            (games) => emit(CampaignGamesLoadedState(campaignId: event.campaignId, games: games)),
          );
        } catch (e) {
          emit(CampaignGamesLoadedState(campaignId: event.campaignId, games: const []));
        }
      }
    });
  }
}
