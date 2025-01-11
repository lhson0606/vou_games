import 'package:vou_games/core/common/data/entities/reward_voucher_entity.dart';

class RewardVoucherModel extends RewardVoucherEntity {
  RewardVoucherModel({required super.id, required super.issuedAt, required super.expiresAt, required super.status, required super.QRCode, required super.voucherType});

  factory RewardVoucherModel.fromJson(Map<String, dynamic> json) {
    return RewardVoucherModel(
      id: json['id'],
      issuedAt: json['issuedAt'],
      expiresAt: json['expiresAt'],
      status: json['status'],
      QRCode: json['QRCode'],
      voucherType: json['voucherType'],
    );
  }
}