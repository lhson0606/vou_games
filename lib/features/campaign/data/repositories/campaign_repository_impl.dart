import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_data_source_contract.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';
import 'package:vou_games/features/campaign/domain/repositories/campaign_repository.dart';

import '../../../../core/services/network/network_info.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/services/user_credential_service.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignDatasource campaignDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferencesService sharedPreferencesService;
  final UserCredentialService userCredentialService;

  CampaignRepositoryImpl(
      {required this.campaignDataSource,
      required this.networkInfo,
      required this.sharedPreferencesService,
      required this.userCredentialService});

  @override
  Future<Either<Failure, List<CampaignEntity>>> getUpComingCampaigns() async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        final campaigns = await campaignDataSource.getUpComingCampaigns();
        return Right(campaigns);
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
