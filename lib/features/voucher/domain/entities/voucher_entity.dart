import 'package:equatable/equatable.dart';

class VoucherEntity extends Equatable {
  final int id;
  final int brandId;
  final String qrCode;
  final String image;
  final double value;
  final String description;
  final String expiryDate;
  final String status;

  const VoucherEntity({
    required this.id,
    required this.brandId,
    required this.qrCode,
    required this.image,
    required this.value,
    required this.description,
    required this.expiryDate,
    required this.status,
  });

  @override
  List<Object?> get props => [id];
}