import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/builders/url/http_url_builder.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/core/network/result_message.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_data_source_contract.dart';
import 'package:vou_games/features/campaign/data/models/campaign_model.dart';
import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:http/http.dart' as http;

class CampaignHttpDataSource extends CampaignDataSource {
  @override
  Future<List<CampaignModel>> getUpComingCampaigns() async {
    UpComingCampaignUrlBuilder builder = HttpUrlBuilderFactory.createCampaignUrlBuilder();
    final DateTime now = DateTime.now();
    final DateTime startOfThisMonth = DateTime(now.year, now.month, 1);
    final DateTime endOfThisMonth = DateTime(now.year, now.month + 1, 0);

    final url =
        builder.startDate(startOfThisMonth).endDate(endOfThisMonth).build();

    http.Response response;

    try {
      response = await http.get(url, headers: config.headers);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ExceptionWithMessage('Error fetching campaigns');
    }

    try {
      ResultMessage res = ResultMessage.fromResponse(response);

      if (res.status == 200 || res.status == 201) {
        var campaignData = res.data as List<dynamic>;
        return campaignData
            .map((campaign) => CampaignModel.fromJson(campaign as Map<String, dynamic>))
            .toList();
      }

      throw ExceptionWithMessage(res.message);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }
  }

  @override
  Future<List<CampaignModel>> searchCampaign(String query) async {
    SearchCampaignUrlBuilder builder = HttpUrlBuilderFactory.createSearchCampaignUrlBuilder();
    final url = builder.term(query).build();

    http.Response response;

    try {
      response = await http.get(url, headers: config.headers);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ExceptionWithMessage('Error searching campaigns');
    }

    try {
      ResultMessage res = ResultMessage.fromResponse(response);

      if (res.status == 200 || res.status == 201) {
        var campaignData = res.data as List<dynamic>;
        return campaignData
            .map((campaign) => CampaignModel.fromJson(campaign as Map<String, dynamic>))
            .toList();
      }

      throw ExceptionWithMessage(res.message);
    } catch (e) {
      final details = FlutterErrorDetails(exception: e);
      FlutterError.dumpErrorToConsole(details);
      rethrow;
    }
  }
}
