import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';
import 'package:vou_games/features/campaign/domain/repositories/campaign_repository.dart';

class GetUpComingCampaignUseCase {
  final CampaignRepository _campaignRepository;

  GetUpComingCampaignUseCase(this._campaignRepository);

  Future<Either<Failure, List<CampaignEntity>>> call() async {
    return await _campaignRepository.getUpComingCampaigns();
  }
}