part of 'campaign_bloc.dart';

abstract class CampaignState extends Equatable{
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitialState extends CampaignState {}

final class LoadingCampaignState extends CampaignState {}

final class LoadingCampaignErrorState extends CampaignState {
  final String error;
  final DateTime timestamp = DateTime.now();

  LoadingCampaignErrorState({required this.error});

  @override
  List<Object> get props => [error, timestamp];
}

final class CampaignsLoadedState extends CampaignState {
  final List<CampaignEntity> campaignList;

  const CampaignsLoadedState({required this.campaignList});

  @override
  List<Object> get props => [campaignList];
}

final class RequestNavigateToCampaignHomepageState extends CampaignState {
  final Widget homepage = const CampaignHomePage();
  final DateTime timestamp = DateTime.now();

  @override
  List<Object> get props => [timestamp];
}

final class NavigateToCampaignHomepageState extends CampaignState {}
