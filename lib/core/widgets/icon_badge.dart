import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Circular icon or initial container (Klarna merchant-logo style).
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    this.icon,
    this.letter,
    this.size = AppSpacing.iconContainer,
    this.background = AppColors.pink,
    this.foreground = AppColors.ink,
  }) : assert(icon != null || letter != null);

  final IconData? icon;
  final String? letter;
  final double size;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: icon != null
            ? Icon(icon, size: size * 0.5, color: foreground)
            : Text(
                letter!,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: size * 0.42,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
      ),
    );
  }
}
