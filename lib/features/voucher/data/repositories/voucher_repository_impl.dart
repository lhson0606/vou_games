import 'package:dartz/dartz.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/voucher/data/datasources/voucher_data_source_contract.dart';
import 'package:vou_games/features/voucher/domain/repositories/voucher_repository.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/voucher_entity.dart';

abstract class VoucherRepositoryImpl extends VoucherRepository {
  final VoucherDataSource voucherDataSource;
  final NetworkInfo networkInfo;
  final UserCredentialService userCredentialService;

  VoucherRepositoryImpl(
      {required this.voucherDataSource,
      required this.networkInfo,
      required this.userCredentialService});

  Future<Either<Failure, List<VoucherEntity>>> getVouchers() async {
    if (await networkInfo.isConnected
        .timeout(const Duration(seconds: 10), onTimeout: () => false)) {
      try {
        final vouchers = await voucherDataSource.getVouchers();
        return Right(vouchers);
      } on Exception {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
