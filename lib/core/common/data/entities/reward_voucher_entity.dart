import 'game_item_entity.dart';
import 'reward_voucher_type_entity.dart';

class RewardVoucherEntity extends GameItemEntity {
  final DateTime? issuedAt;
  final DateTime? expiresAt;
  final String status;
  final String QRCode;
  final RewardVoucherTypeEntity voucherType;

  RewardVoucherEntity(
      {required super.id,
      required this.issuedAt,
      required this.expiresAt,
      required this.status,
      required this.QRCode,
      required this.voucherType});

  @override
  String getDisplayDescription() {
    return "A voucher for ${voucherType.name} with a value of ${voucherType.value * 100} discount percent!";
  }

  @override
  String getDisplayImageUrl() {
    return voucherType.imageUrl;
  }

  @override
  String getDisplayName() {
    return voucherType.name;
  }
}
