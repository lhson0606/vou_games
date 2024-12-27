import '../models/voucher_model.dart';

abstract class VoucherDataSource {
  Future<List<VoucherModel>> getVouchers();
}