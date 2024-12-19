part of 'campaign_bloc.dart';

abstract class CampaignEvent extends Equatable{
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class RequestNavigateToCampaignHomepageEvent extends CampaignEvent{}

class NavigateToCampaignHomepageEvent extends CampaignEvent{}

class GetUpComingCampaignEvent extends CampaignEvent{}
