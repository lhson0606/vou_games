import 'package:flutter/material.dart';

/**
 * SnackBar(
    action: SnackBarAction(
    label: 'Ok',
    onPressed: () {
    // Code to execute.
    },
    ),
    content: Text(message),
    duration: const Duration(milliseconds: 1500),
    width: 280.0,
    // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
    horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    );
 */
enum SnackBarType { success, error, warning, info }

void showSnackBar(BuildContext context, String message,
    {SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(milliseconds: 1500)}) {
  Color backgroundColor;
  Color textColor;
  IconData icon;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green;
      textColor = Colors.white;
      icon = Icons.check_circle;
      break;
    case SnackBarType.error:
      backgroundColor = Colors.red;
      textColor = Colors.white;
      icon = Icons.error;
      break;
    case SnackBarType.warning:
      backgroundColor = Colors.orange;
      textColor = Colors.white;
      icon = Icons.warning;
      break;
    case SnackBarType.info:
      backgroundColor = Colors.blue;
      textColor = Colors.white;
      icon = Icons.info;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Code to execute.
        },
      ),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 8.0),
          Expanded(child: Text(message, style: TextStyle(color: textColor))),
        ],
      ),
      duration: duration,
      width: 280.0,
      // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
