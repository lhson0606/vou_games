import 'dart:convert';

import 'package:vou_games/configs/mock/campaign_mock.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_data_source_contract.dart';
import 'package:vou_games/features/campaign/data/models/campaign_model.dart';

class CampaignLocalDataSource extends CampaignDataSource {
  @override
  Future<List<CampaignModel>> getUpComingCampaigns() {
    final List<dynamic> jsonList = json.decode(MOCK_CAMPAIGNS_JSON);
    return Future.value(jsonList.map((e) => CampaignModel.fromJson(e)).toList());
  }
}
