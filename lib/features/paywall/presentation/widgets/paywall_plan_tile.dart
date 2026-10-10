import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/paywall_plan.dart';

final NumberFormat _wholeRupees = NumberFormat('#,##0', 'en_US');

/// Compact PKR price for the paywall, e.g. "Rs 1,100" (no decimals).
String formatPaywallPrice(double amount) =>
    'Rs ${_wholeRupees.format(amount.round())}';

/// One of the three side-by-side plan cards: period, price and what it works
/// out to per week. The popular plan carries a badge over its top edge.
class PaywallPlanTile extends StatelessWidget {
  const PaywallPlanTile({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.isPopular,
    required this.onTap,
  });

  final PaywallPlan plan;
  final bool isSelected;
  final bool isPopular;
  final VoidCallback onTap;

  static const double minHeight = 98;
  static const double radius = 18;
  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(radius),
  );

  String get _subtitle => switch (plan.period) {
    PlanPeriod.weekly => 'Billed weekly',
    _ => 'Only ${formatPaywallPrice(plan.pricePerWeek)}/week',
  };

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final price = formatPaywallPrice(plan.price);
    final periodName = plan.label[0] + plan.label.substring(1).toLowerCase();

    return Semantics(
      button: true,
      selected: isSelected,
      label:
          '$periodName plan, $price. $_subtitle'
          '${isPopular ? '. Popular' : ''}',
      excludeSemantics: true,
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          AnimatedContainer(
            duration: reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            constraints: const BoxConstraints(minHeight: minHeight),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.pinkSoft : AppColors.surface,
              borderRadius: _borderRadius,
              border: Border.all(
                color: isSelected ? AppColors.pinkStrong : AppColors.border,
                width: 2,
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: _borderRadius,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 14, 6, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _OneLine(
                        plan.label,
                        style: TextStyle(
                          fontSize: 11.5,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: isSelected
                              ? AppColors.pinkStrong
                              : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _OneLine(
                        price,
                        style: const TextStyle(
                          fontSize: 22,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: AppColors.textPrimary,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: 4),
                      _OneLine(
                        _subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isPopular)
            const Positioned(top: -11, child: PaywallPopularBadge()),
        ],
      ),
    );
  }
}

/// Single-line text that shrinks to fit a narrow tile instead of clipping.
class _OneLine extends StatelessWidget {
  const _OneLine(this.text, {required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text, maxLines: 1, style: style),
    );
  }
}

/// Flame + "POPULAR" pill on a pink gradient.
class PaywallPopularBadge extends StatelessWidget {
  const PaywallPopularBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.pinkStrong, AppColors.pink],
          ),
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: MediaQuery.withNoTextScaling(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 12,
                  color: AppColors.onInk,
                ),
                SizedBox(width: 2),
                Text(
                  'POPULAR',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                    color: AppColors.onInk,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
