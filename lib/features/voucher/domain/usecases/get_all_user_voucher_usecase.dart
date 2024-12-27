import 'package:dartz/dartz.dart';
import 'package:vou_games/features/voucher/domain/repositories/voucher_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/voucher_entity.dart';

class GetAllUserVoucherUsecase {
  final VoucherRepository _voucherRepository;

  GetAllUserVoucherUsecase(this._voucherRepository);

  Future<Either<Failure, List<VoucherEntity>>> call() async {
    return await _voucherRepository.getVouchers();
  }
}