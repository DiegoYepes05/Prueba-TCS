import 'package:flutter/material.dart';
import 'package:shared/widgets/toastification.dart';

extension AppToastificationExtension on BuildContext {
  void showSuccessToastification({required String message, String? title}) {
    AppToastification.showSuccess(
      context: this,
      message: message,
      title: title,
    );
  }

  void showErrorToastification({required String message, String? title}) {
    AppToastification.showError(context: this, message: message, title: title);
  }
}
