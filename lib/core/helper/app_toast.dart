import 'package:flutter/material.dart';

abstract class AppToast {
  static void _show(
      BuildContext context,
      String message, {
        Color? backgroundColor,
        Color? textColor,
        SnackBarBehavior behavior = SnackBarBehavior.floating,
      }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: behavior,
        backgroundColor:
        backgroundColor ?? theme.colorScheme.surface.withOpacity(0.98),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: textColor ?? theme.colorScheme.onSurface,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }


  static void show(
      BuildContext context,
      String message,
      ) {
    _show(context, message);
  }


  static void success(BuildContext context, String message) {
    final theme = Theme.of(context);
    _show(
      context,
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }


  static void error(BuildContext context, String message) {
    _show(
      context,
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
