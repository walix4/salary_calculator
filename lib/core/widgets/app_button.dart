import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, tonal }

/// Full-width pill button. Primary is the near-black Klarna CTA; secondary is
/// outlined; tonal is the light grey pill used for low-emphasis actions.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
    this.compact = false,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = true,
    this.compact = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.tonal({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = true,
    this.compact = false,
  }) : variant = AppButtonVariant.tonal;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  /// Smaller pill (e.g. empty-state CTAs).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final foreground = variant == AppButtonVariant.primary
        ? AppColors.onInk
        : AppColors.ink;
    final child = isLoading
        ? SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == AppButtonVariant.primary
                  ? AppColors.textSecondary
                  : AppColors.ink,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.iconSize, color: foreground),
                const SizedBox(width: AppSpacing.xs),
              ],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    final size = Size(
      expand ? double.infinity : 64,
      compact ? 40 : AppSpacing.buttonHeight,
    );
    final padding = EdgeInsets.symmetric(
      horizontal: compact ? AppSpacing.md : AppSpacing.lg,
    );
    final callback = isLoading ? null : onPressed;

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: callback,
        style: FilledButton.styleFrom(minimumSize: size, padding: padding),
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        style: OutlinedButton.styleFrom(minimumSize: size, padding: padding),
        child: child,
      ),
      AppButtonVariant.tonal => FilledButton(
        onPressed: callback,
        style: FilledButton.styleFrom(
          minimumSize: size,
          padding: padding,
          backgroundColor: AppColors.surfaceStrong,
          foregroundColor: AppColors.ink,
        ),
        child: child,
      ),
    };

    // Keep the loading state visually "active" instead of disabled grey.
    if (isLoading && variant == AppButtonVariant.primary) {
      return Semantics(
        label: label,
        button: true,
        enabled: false,
        child: FilledButton(
          onPressed: null,
          style: FilledButton.styleFrom(
            minimumSize: size,
            disabledBackgroundColor: AppColors.surfaceStrong,
          ),
          child: child,
        ),
      );
    }
    return button;
  }
}
