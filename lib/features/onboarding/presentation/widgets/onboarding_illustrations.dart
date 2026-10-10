import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// Flat, soft illustrations for the onboarding pages, built purely from
/// widgets (no image assets). All are decorative and excluded from semantics.

const double _illustrationWidth = 260;
const double _outline = 2;

/// Stacked "breakdown card" mock: a white card with an ink outline sitting on
/// pink and lavender layers, showing abstract bars and lines.
class BreakdownIllustration extends StatelessWidget {
  const BreakdownIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: _illustrationWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Back layers peeking out below the main card.
            Positioned(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              bottom: 0,
              height: AppSpacing.xxl,
              child: _layer(AppColors.purple.withValues(alpha: 0.45)),
            ),
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.xs,
              height: AppSpacing.xxl,
              child: _layer(AppColors.pink),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md + 2),
              child: _MainCard(),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _layer(Color color) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      borderRadius: AppRadii.lgAll,
      border: Border.all(color: AppColors.ink, width: _outline),
    ),
  );
}

class _MainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: AppColors.ink, width: _outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: AppSpacing.iconContainer,
                height: AppSpacing.iconContainer,
                decoration: const BoxDecoration(
                  color: AppColors.pinkSoft,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.payments_outlined,
                  size: AppSpacing.iconSize,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Line(widthFactor: 0.8, color: AppColors.surfaceStrong),
                    SizedBox(height: AppSpacing.xs),
                    _Line(widthFactor: 0.45, color: AppColors.surfaceStrong),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Abstract breakdown bars: one long "earnings" bar, shorter
          // "deduction" bars.
          const _Bar(widthFactor: 1, color: AppColors.pink),
          const SizedBox(height: AppSpacing.xs),
          const _Bar(widthFactor: 0.38, color: AppColors.lavender),
          const SizedBox(height: AppSpacing.xs),
          const _Bar(widthFactor: 0.22, color: AppColors.lavender),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          const Row(
            children: [
              Expanded(
                child: _Line(widthFactor: 0.5, color: AppColors.surfaceStrong),
              ),
              _Pill(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.widthFactor, required this.color});

  final double widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        height: AppSpacing.xs,
        decoration: BoxDecoration(color: color, borderRadius: AppRadii.pillAll),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.widthFactor, required this.color});

  final double widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        height: AppSpacing.sm,
        decoration: BoxDecoration(color: color, borderRadius: AppRadii.pillAll),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.xxl + AppSpacing.md,
      height: AppSpacing.md + AppSpacing.xxs,
      decoration: const BoxDecoration(
        color: AppColors.ink,
        borderRadius: AppRadii.pillAll,
      ),
    );
  }
}

/// Lock inside layered pink circles, with small orbiting accents.
class PrivacyIllustration extends StatelessWidget {
  const PrivacyIllustration({super.key});

  static const double _size = 184;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: _illustrationWidth,
        height: _size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _size,
              height: _size,
              decoration: const BoxDecoration(
                color: AppColors.pinkSoft,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: _size * 0.66,
              height: _size * 0.66,
              decoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.ink, width: _outline),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.shield_outlined,
                size: _size * 0.34,
                color: AppColors.ink,
              ),
            ),
            Positioned(
              right: AppSpacing.lg,
              top: AppSpacing.md,
              child: _Accent(
                icon: Icons.lock_outline,
                background: AppColors.purpleSoft,
              ),
            ),
            Positioned(
              left: AppSpacing.lg,
              bottom: AppSpacing.md,
              child: _Accent(
                icon: Icons.phone_iphone,
                background: AppColors.lavenderBanner,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Accent extends StatelessWidget {
  const _Accent({required this.icon, required this.background});

  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.iconContainer + AppSpacing.xxs,
      height: AppSpacing.iconContainer + AppSpacing.xxs,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.ink, width: _outline),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: AppSpacing.iconSize, color: AppColors.ink),
    );
  }
}
