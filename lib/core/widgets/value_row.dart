import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Label / value line used in financial breakdowns.
class ValueRow extends StatelessWidget {
  const ValueRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasized = false,
    this.valueColor,
    this.caption,
  });

  final String label;
  final String value;
  final bool emphasized;
  final Color? valueColor;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final labelStyle = emphasized
        ? AppTypography.cardTitle
        : AppTypography.body.copyWith(color: AppColors.textSecondary);
    final valueStyle =
        (emphasized
                ? AppTypography.amount.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  )
                : AppTypography.amount.copyWith(fontWeight: FontWeight.w500))
            .copyWith(color: valueColor);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: labelStyle),
                  if (caption != null)
                    Text(caption!, style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Amounts stay on one line and shrink rather than wrap.
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(value, style: valueStyle, maxLines: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
