part of 'campaign_bloc.dart';

abstract class CampaignState extends Equatable{
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitialState extends CampaignState {}

final class UpcomingCampaignLoadingState extends CampaignState {}

final class UpcomingCampaignErrorState extends CampaignState {
  final String error;
  final DateTime timestamp = DateTime.now();

  UpcomingCampaignErrorState({required this.error});

  @override
  List<Object> get props => [error, timestamp];
}

final class UpcomingCampaignLoadedState extends CampaignState {
  final List<CampaignEntity> campaignList;

  const UpcomingCampaignLoadedState({required this.campaignList});

  @override
  List<Object> get props => [campaignList];
}

final class RequestNavigateToCampaignHomepageState extends CampaignState {
  final Widget homepage = const CampaignHomePage();

  @override
  List<Object> get props => [homepage];
}

final class NavigateToCampaignHomepageState extends CampaignState {}
