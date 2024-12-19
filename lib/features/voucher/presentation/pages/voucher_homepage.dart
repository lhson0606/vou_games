import 'package:flutter/material.dart';
import 'package:vou_games/core/services/navigation_service.dart';
import 'package:vou_games/injection_container.dart' as di;

class VoucherHomepage extends StatelessWidget {
  const VoucherHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher Homepage'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Voucher Homepage'),
            TextButton(
              onPressed: () {
                // di.setupNavigationService();
                // di.sl<NavigationService>().hideNavigationBar();
              },
              child: const Text('testing'),
            ),
          ],
        ),
      ),
    );
  }
}