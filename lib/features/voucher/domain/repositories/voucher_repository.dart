import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/voucher/domain/entities/voucher_entity.dart';

abstract class VoucherRepository {
  Future<Either<Failure, List<VoucherEntity>>> getVouchers();
}