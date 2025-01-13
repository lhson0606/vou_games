import 'package:vou_games/configs/server/http/bff_config.dart' as config;
import 'package:intl/intl.dart';

class HttpUrlBuilderFactory {
  static UpComingCampaignUrlBuilder createCampaignUrlBuilder() {
    return UpComingCampaignUrlBuilder();
  }

  static SearchCampaignUrlBuilder createSearchCampaignUrlBuilder() {
    return SearchCampaignUrlBuilder();
  }

  static CampaignGameUrlBuilder createCampaignGameUrlBuilder() {
    return CampaignGameUrlBuilder();
  }
}

class UpComingCampaignUrlBuilder {
  String _urlString = config.Campaign.campaigns;

  UpComingCampaignUrlBuilder startDate(DateTime startDate) {
    String date = DateFormat('yyyy-MM-dd').format(startDate);
    if (_urlString.contains('startDate=')) {
      _urlString = _urlString.replaceFirst(
          RegExp(r'startDate=[0-9]{4}-[0-9]{2}-[0-9]{2}'), 'startDate=$date');
    } else if (!_urlString.contains('?')) {
      _urlString += '?startDate=$date';
    } else {
      _urlString += '&startDate=$date';
    }
    return this;
  }

  UpComingCampaignUrlBuilder endDate(DateTime endDate) {
    String date = DateFormat('yyyy-MM-dd').format(endDate);
    if (_urlString.contains('endDate=')) {
      _urlString = _urlString.replaceFirst(
          RegExp(r'endDate=[0-9]{4}-[0-9]{2}-[0-9]{2}'), 'endDate=$date');
    } else if (!_urlString.contains('?')) {
      _urlString += '?endDate=$date';
    } else {
      _urlString += '&endDate=$date';
    }
    return this;
  }

  Uri build() {
    return Uri.parse(_urlString);
  }
}

class SearchCampaignUrlBuilder {
  String _urlString = config.Campaign.search;

  SearchCampaignUrlBuilder term(String term) {
    if (_urlString.contains('term=')) {
      _urlString =
          _urlString.replaceFirst(RegExp(r'query=[a-zA-Z0-9]+'), 'term=$term');
    } else if (!_urlString.contains('?')) {
      _urlString += '?term=$term';
    } else {
      _urlString += '&term=$term';
    }
    return this;
  }

  Uri build() {
    return Uri.parse(_urlString);
  }
}

class CampaignGameUrlBuilder {
  String _urlString = config.Campaign.game;

  CampaignGameUrlBuilder campaignId(int campaignId) {
    if (_urlString.contains('{campaignId}')) {
      _urlString =
          _urlString.replaceFirst('{campaignId}', campaignId.toString());
    }
    return this;
  }

  Uri build() {
    return Uri.parse(_urlString);
  }
}
