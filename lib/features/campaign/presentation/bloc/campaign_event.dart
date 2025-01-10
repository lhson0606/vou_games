part of 'campaign_bloc.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();
}

class RequestNavigateToCampaignHomepageEvent extends CampaignEvent {
  @override
  List<Object?> get props => [];
}

class NavigateToCampaignHomepageEvent extends CampaignEvent {
  @override
  List<Object?> get props => [];
}

class GetUpComingCampaignEvent extends CampaignEvent {
  @override
  List<Object?> get props => throw [];
}

class SearchCampaignEvent extends CampaignEvent {
  final String term;

  const SearchCampaignEvent(this.term);

  @override
  List<Object?> get props => [term];
}
