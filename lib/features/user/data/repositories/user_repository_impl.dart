import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/user/data/datasources/user_data_source_contract.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';
import 'package:vou_games/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final NetworkInfo networkInfo;
  final UserCredentialService userCredentialService;

  UserRepositoryImpl(
      {required this.userDataSource,
      required this.networkInfo,
      required this.userCredentialService});

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        final userProfile = await userDataSource.getUserProfile();
        return Right(userProfile);
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
