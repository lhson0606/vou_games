import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/user/data/datasources/user_data_source_contract.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';
import 'package:vou_games/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  final NetworkInfo _networkInfo;
  final UserCredentialService _userCredentialService;

  UserRepositoryImpl(
      this._userDataSource, this._networkInfo, this._userCredentialService);

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    if (await _networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        final userProfile = await _userDataSource.getUserProfile();
        return Right(userProfile);
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
