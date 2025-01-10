import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

import '../repositories/campaign_repository.dart';

class SearchCampaignUseCase {
  final CampaignRepository _campaignRepository;

  SearchCampaignUseCase(this._campaignRepository);

  Future<Either<Failure, List<CampaignEntity>>> execute(String query) {
    return _campaignRepository.searchCampaign(query);
  }
}