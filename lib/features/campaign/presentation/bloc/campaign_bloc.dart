import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/campaign/domain/usecases/get_up_coming_campaign_usecase.dart';
import 'package:vou_games/features/campaign/domain/usecases/search_campaign_usecase.dart';
import 'package:vou_games/features/campaign/presentation/pages/campaign_homepage.dart';

import '../../domain/entities/campaign_entity.dart';

part 'campaign_event.dart';

part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  GetUpComingCampaignUseCase getUpComingCampaignUseCase;
  SearchCampaignUseCase searchCampaignUseCase;

  CampaignBloc({required this.getUpComingCampaignUseCase, required this.searchCampaignUseCase})
      : super(CampaignInitialState()) {
    on<CampaignEvent>((event, emit) async {
      if (event is GetUpComingCampaignEvent) {
        emit(LoadingCampaignState());
        final failureOrCampaignList = await getUpComingCampaignUseCase();
        failureOrCampaignList.fold(
            (failure) => emit(LoadingCampaignErrorState(
                error: failureToErrorMessage(failure))),
            (campaignList) =>
                emit(CampaignsLoadedState(campaignList: campaignList)));
      } else if (event is RequestNavigateToCampaignHomepageEvent) {
        emit(RequestNavigateToCampaignHomepageState());
      } else if(event is SearchCampaignEvent) {
        emit(LoadingCampaignState());
        final failureOrCampaignList = await searchCampaignUseCase.execute(event.term);
        failureOrCampaignList.fold(
            (failure) => emit(LoadingCampaignErrorState(
                error: failureToErrorMessage(failure))),
            (campaignList) =>
                emit(CampaignsLoadedState(campaignList: campaignList)));
      }
    });
  }
}
