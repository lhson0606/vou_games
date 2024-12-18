part of 'campaign_bloc.dart';

abstract class CampaignEvent extends Equatable{
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class GetUpComingCampaignEvent extends CampaignEvent{}
