import 'package:flutter/material.dart';
import 'package:vou_games/features/voucher/domain/entities/voucher_entity.dart';

class VoucherItem extends StatelessWidget {
  final VoucherEntity voucher;

  const VoucherItem({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                voucher.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(voucher.value * 100).toStringAsFixed(0)}% Discount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    voucher.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Expires on: ${voucher.expiryDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}