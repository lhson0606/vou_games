import 'dart:convert';

import 'package:vou_games/configs/mock/voucher_mock.dart';
import 'package:vou_games/features/voucher/data/datasources/voucher_data_source_contract.dart';
import 'package:vou_games/features/voucher/data/models/voucher_model.dart';

class VoucherLocalDataSource extends VoucherDataSource {
  @override
  Future<List<VoucherModel>> getVouchers() {
    final List<dynamic> jsonList = json.decode(MOCK_VOUCHERS_JSON);
    return Future.value(jsonList.map((e) => VoucherModel.fromJson(e)).toList());
  }
}
