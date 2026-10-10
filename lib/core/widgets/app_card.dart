import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum AppCardStyle {
  /// Light grey fill, no border — Klarna's default grouped surface.
  filled,

  /// White with a hairline border.
  outlined,

  /// Pale pink brand surface for highlights.
  brand,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.style = AppCardStyle.filled,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
  });

  final Widget child;
  final AppCardStyle style;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (color, border) = switch (style) {
      AppCardStyle.filled => (AppColors.surface, BorderSide.none),
      AppCardStyle.outlined => (
        AppColors.card,
        const BorderSide(color: AppColors.border),
      ),
      AppCardStyle.brand => (AppColors.pinkSoft, BorderSide.none),
    };

    return Material(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.lgAll, side: border),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
