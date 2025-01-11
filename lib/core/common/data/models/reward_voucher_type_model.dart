import '../entities/reward_voucher_type_entity.dart';

class RewardVoucherTypeModel extends RewardVoucherTypeEntity {
  RewardVoucherTypeModel(
      {required super.id,
      required super.name,
      required super.value,
      required super.imageUrl,
      required super.description,
      required super.brandId});

  factory RewardVoucherTypeModel.fromJson(Map<String, dynamic> json) {
    return RewardVoucherTypeModel(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      brandId: json['brandId'],
    );
  }
}
