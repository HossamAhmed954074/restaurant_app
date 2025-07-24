import 'package:flutter/material.dart';

void showSnakBarFaluire(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      showCloseIcon: true,
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}
