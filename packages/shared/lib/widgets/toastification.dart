import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToastification {
  static void showError({
    required BuildContext context,
    required String message,
    String? title = 'Error',
  }) {
    _showToastification(
      context: context,
      message: message,
      title: title,
      type: ToastificationType.error,
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    String? title = 'Completado',
  }) {
    _showToastification(
      context: context,
      message: message,
      title: title,
      type: ToastificationType.success,
    );
  }

  static void _showToastification({
    required BuildContext context,
    required String message,
    String? title,
    required ToastificationType type,
  }) {
    // final ThemeData theme = Theme.of(context);
    toastification
      ..dismissAll()
      ..show(
        context: context,
        title: Text(title ?? ''),
        description: Text(message),
        type: type,
        showIcon: true,
      );
  }
}
