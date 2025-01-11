class RewardVoucherTypeEntity {
  final int id;
  final String name;
  final double value;
  final String imageUrl;
  final String description;
  final int brandId;

  const RewardVoucherTypeEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.imageUrl,
    required this.description,
    required this.brandId,
  });
}