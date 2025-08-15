import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum NotificationType { success, error, warning, info }

enum NotificationDuration { short, medium, long, persistent }

class AppNotification {
  static FToast? _fToast;

  static void init(BuildContext context) {
    _fToast = FToast();
    _fToast!.init(context);
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    NotificationType type = NotificationType.info,
    NotificationDuration duration = NotificationDuration.medium,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle_outline;
        break;
      case NotificationType.error:
        backgroundColor = colorScheme.error;
        textColor = colorScheme.onError;
        icon = Icons.error_outline;
        break;
      case NotificationType.warning:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        icon = Icons.warning_amber_rounded;
        break;
      case NotificationType.info:
        backgroundColor = colorScheme.primary;
        textColor = colorScheme.onPrimary;
        icon = Icons.info_outline;
        break;
    }

    Duration snackBarDuration;
    switch (duration) {
      case NotificationDuration.short:
        snackBarDuration = const Duration(seconds: 2);
        break;
      case NotificationDuration.medium:
        snackBarDuration = const Duration(seconds: 4);
        break;
      case NotificationDuration.long:
        snackBarDuration = const Duration(seconds: 6);
        break;
      case NotificationDuration.persistent:
        snackBarDuration = const Duration(days: 365); // Sangat lama
        break;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: snackBarDuration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: textColor,
              onPressed: onActionPressed ?? () {},
            )
          : null,
      showCloseIcon:
          showCloseButton || duration == NotificationDuration.persistent,
      closeIconColor: textColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showToast(
    BuildContext context,
    String message, {
    NotificationType type = NotificationType.info,
    NotificationDuration duration = NotificationDuration.short,
  }) {
    if (_fToast == null) {
      init(context);
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle_outline;
        break;
      case NotificationType.error:
        backgroundColor = colorScheme.error;
        textColor = colorScheme.onError;
        icon = Icons.error_outline;
        break;
      case NotificationType.warning:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        icon = Icons.warning_amber_rounded;
        break;
      case NotificationType.info:
        backgroundColor = colorScheme.surface;
        textColor = colorScheme.onSurface;
        icon = Icons.info_outline;
        break;
    }

    Duration toastDuration;
    switch (duration) {
      case NotificationDuration.short:
        toastDuration = const Duration(seconds: 2);
        break;
      case NotificationDuration.medium:
        toastDuration = const Duration(seconds: 3);
        break;
      case NotificationDuration.long:
        toastDuration = const Duration(seconds: 5);
        break;
      case NotificationDuration.persistent:
        toastDuration = const Duration(seconds: 3);
        break;
    }

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    _fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: toastDuration,
    );
  }

  // SnackBar shortcuts
  static void success(
    BuildContext context,
    String message, {
    NotificationDuration duration = NotificationDuration.medium,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    showSnackBar(
      context,
      message,
      type: NotificationType.success,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    NotificationDuration duration = NotificationDuration.long,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = true,
  }) {
    showSnackBar(
      context,
      message,
      type: NotificationType.error,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: showCloseButton,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    NotificationDuration duration = NotificationDuration.medium,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    showSnackBar(
      context,
      message,
      type: NotificationType.warning,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    NotificationDuration duration = NotificationDuration.medium,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    showSnackBar(
      context,
      message,
      type: NotificationType.info,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void notification(
    BuildContext context,
    String message, {
    NotificationType type = NotificationType.info,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    showSnackBar(
      context,
      message,
      type: type,
      duration: NotificationDuration.persistent,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: true,
    );
  }

  // Toast shortcuts
  static void successToast(BuildContext context, String message) {
    showToast(context, message, type: NotificationType.success);
  }

  static void errorToast(BuildContext context, String message) {
    showToast(context, message, type: NotificationType.error);
  }

  static void warningToast(BuildContext context, String message) {
    showToast(context, message, type: NotificationType.warning);
  }

  static void infoToast(BuildContext context, String message) {
    showToast(context, message, type: NotificationType.info);
  }

  // Utility methods
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void hideToast() {
    _fToast?.removeCustomToast();
  }
}
