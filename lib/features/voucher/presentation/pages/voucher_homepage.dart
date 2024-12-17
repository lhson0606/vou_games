import 'package:flutter/material.dart';

class VoucherHomepage extends StatelessWidget {
  const VoucherHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher Homepage'),
      ),
      body: const Center(
        child: Text('Voucher Homepage'),
      ),
    );
  }
}