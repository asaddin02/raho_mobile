import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

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
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    Color backgroundColor;
    Color textColor;
    Color iconColor;
    IconData icon;
    Color borderColor;

    switch (type) {
      case NotificationType.success:
        backgroundColor = isDark
            ? const Color(0xFF1B4332)
            : const Color(0xFFE8F5E8);
        textColor = isDark ? const Color(0xFF4CAF50) : const Color(0xFF2E7D32);
        iconColor = const Color(0xFF4CAF50);
        borderColor = const Color(0xFF4CAF50).withValues(alpha: 0.3);
        icon = Icons.check_circle_rounded;
        break;
      case NotificationType.error:
        backgroundColor = isDark
            ? const Color(0xFF4A1E1E)
            : const Color(0xFFFFF2F2);
        textColor = isDark ? const Color(0xFFF44336) : const Color(0xFFD32F2F);
        iconColor = const Color(0xFFF44336);
        borderColor = const Color(0xFFF44336).withValues(alpha: 0.3);
        icon = Icons.error_rounded;
        break;
      case NotificationType.warning:
        backgroundColor = isDark
            ? const Color(0xFF4A3A1E)
            : const Color(0xFFFFF8E1);
        textColor = isDark ? const Color(0xFFFF9800) : const Color(0xFFE65100);
        iconColor = const Color(0xFFFF9800);
        borderColor = const Color(0xFFFF9800).withValues(alpha: 0.3);
        icon = Icons.warning_rounded;
        break;
      case NotificationType.info:
        backgroundColor = isDark
            ? const Color(0xFF1E3A4A)
            : const Color(0xFFE3F2FD);
        textColor = isDark ? const Color(0xFF2196F3) : const Color(0xFF1976D2);
        iconColor = const Color(0xFF2196F3);
        borderColor = const Color(0xFF2196F3).withValues(alpha: 0.3);
        icon = Icons.info_rounded;
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
        snackBarDuration = const Duration(days: 365);
        break;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: iconColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLarge,
          vertical: AppSizes.paddingMedium + AppSizes.paddingTiny,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.paddingTiny),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            SizedBox(width: AppSizes.spacingSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getTypeTitle(type, l10n),
                    style: AppTextStyle.caption
                        .withColor(textColor)
                        .withWeight(AppFontWeight.semiBold),
                  ),
                  SizedBox(height: AppSizes.spacingTiny * 0.5),
                  Text(
                    message,
                    style: AppTextStyle.body
                        .withColor(textColor.withValues(alpha: 0.9))
                        .withWeight(AppFontWeight.regular)
                        .withSize(13),
                  ),
                ],
              ),
            ),
            if (actionLabel != null) ...[
              SizedBox(width: AppSizes.spacingSmall),
              TextButton(
                onPressed: onActionPressed ?? () {},
                style: TextButton.styleFrom(
                  foregroundColor: iconColor,
                  backgroundColor: iconColor.withValues(alpha: 0.1),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                ),
                child: Text(
                  actionLabel,
                  style: AppTextStyle.caption.withWeight(
                    AppFontWeight.semiBold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: snackBarDuration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(AppSizes.marginLarge),
      showCloseIcon:
          showCloseButton || duration == NotificationDuration.persistent,
      closeIconColor: iconColor,
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
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    Color backgroundColor;
    Color textColor;
    Color iconColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        backgroundColor = isDark
            ? const Color(0xFF1B4332)
            : const Color(0xFFE8F5E8);
        textColor = isDark ? Colors.white : const Color(0xFF2E7D32);
        iconColor = const Color(0xFF4CAF50);
        icon = Icons.check_circle_rounded;
        break;
      case NotificationType.error:
        backgroundColor = isDark
            ? const Color(0xFF4A1E1E)
            : const Color(0xFFFFF2F2);
        textColor = isDark ? Colors.white : const Color(0xFFD32F2F);
        iconColor = const Color(0xFFF44336);
        icon = Icons.error_rounded;
        break;
      case NotificationType.warning:
        backgroundColor = isDark
            ? const Color(0xFF4A3A1E)
            : const Color(0xFFFFF8E1);
        textColor = isDark ? Colors.white : const Color(0xFFE65100);
        iconColor = const Color(0xFFFF9800);
        icon = Icons.warning_rounded;
        break;
      case NotificationType.info:
        backgroundColor = isDark
            ? const Color(0xFF1E3A4A)
            : const Color(0xFFE3F2FD);
        textColor = isDark ? Colors.white : const Color(0xFF1976D2);
        iconColor = const Color(0xFF2196F3);
        icon = Icons.info_rounded;
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

    Widget toast = TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.7 + (0.3 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppSizes.marginLarge),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
                vertical: AppSizes.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSizes.paddingSmall - 2),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusTiny + 2,
                      ),
                    ),
                    child: Icon(icon, color: iconColor, size: 18),
                  ),
                  SizedBox(width: AppSizes.spacingSmall),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getTypeTitle(type, l10n),
                          style: AppTextStyle.caption
                              .withColor(textColor)
                              .withWeight(AppFontWeight.semiBold),
                        ),
                        if (message.isNotEmpty) ...[
                          SizedBox(height: AppSizes.spacingTiny * 0.25),
                          Text(
                            message,
                            style: AppTextStyle.caption
                                .withColor(textColor.withValues(alpha: 0.8))
                                .withWeight(AppFontWeight.regular)
                                .withSize(11),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    _fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: toastDuration,
    );
  }

  static String _getTypeTitle(NotificationType type, AppLocalizations l10n) {
    switch (type) {
      case NotificationType.success:
        return l10n.success;
      case NotificationType.error:
        return l10n.error;
      case NotificationType.warning:
        return l10n.warning;
      case NotificationType.info:
        return l10n.info;
    }
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
