import 'package:vou_games/features/voucher/domain/entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.id,
    required super.brandId,
    required super.qrCode,
    required super.image,
    required super.value,
    required super.description,
    required super.expiryDate,
    required super.status,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      brandId: json['brandId'],
      qrCode: json['qrCode'],
      image: json['image'],
      value: json['value'],
      description: json['description'],
      expiryDate: json['expiryDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandId': brandId,
      'qrCode': qrCode,
      'image': image,
      'value': value,
      'description': description,
      'expiryDate': expiryDate,
      'status': status,
    };
  }
}