import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<Either<Failure, List<CampaignEntity>>> getUpComingCampaigns();

  Future<Either<Failure, List<CampaignEntity>>> searchCampaign(String query);

}