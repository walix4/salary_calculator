import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum AppToastType { success, error, info }

/// Mint-green (or error/info) floating toast with icon and close button.
void showAppToast(
  BuildContext context,
  String message, {
  AppToastType type = AppToastType.success,
}) {
  final (background, iconColor, icon) = switch (type) {
    AppToastType.success => (
      AppColors.toastSuccess,
      AppColors.success,
      Icons.check_circle,
    ),
    AppToastType.error => (AppColors.errorSoft, AppColors.error, Icons.error),
    AppToastType.info => (
      AppColors.lavenderBanner,
      AppColors.purple,
      Icons.info,
    ),
  };
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: background,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.lgAll),
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, 6, 4, 6),
        content: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              tooltip: 'Dismiss',
              icon: const Icon(Icons.close, size: 20, color: AppColors.ink),
              onPressed: messenger.hideCurrentSnackBar,
            ),
          ],
        ),
      ),
    );
}
