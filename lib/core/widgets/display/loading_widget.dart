import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        color: theme.colorScheme.primary,
      ),
    );
  }
}
