import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/campaign/domain/usecases/get_up_coming_campaign_usecase.dart';
import 'package:vou_games/features/campaign/presentation/pages/campaign_homepage.dart';

import '../../domain/entities/campaign_entity.dart';

part 'campaign_event.dart';

part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  GetUpComingCampaignUseCase getUpComingCampaignUseCase;

  CampaignBloc({required this.getUpComingCampaignUseCase})
      : super(CampaignInitialState()) {
    on<CampaignEvent>((event, emit) async {
      if (event is GetUpComingCampaignEvent) {
        emit(UpcomingCampaignLoadingState());
        // mock waiting for 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        final failureOrCampaignList = await getUpComingCampaignUseCase();
        failureOrCampaignList.fold(
            (failure) => emit(UpcomingCampaignErrorState(
                error: failureToErrorMessage(failure))),
            (campaignList) =>
                emit(UpcomingCampaignLoadedState(campaignList: campaignList)));
      } else if (event is RequestNavigateToCampaignHomepageEvent) {
        emit(RequestNavigateToCampaignHomepageState());
      }
    });
  }
}
