import 'package:vou_games/features/campaign/data/models/campaign_model.dart';

abstract class CampaignDataSource {
  Future<List<CampaignModel>> getUpComingCampaigns();
}