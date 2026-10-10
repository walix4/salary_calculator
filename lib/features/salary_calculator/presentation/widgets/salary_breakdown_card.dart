import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/salary_breakdown.dart';

/// Grey filled card listing the full salary calculation: gross, prorated,
/// deductions and the net payable total.
class SalaryBreakdownCard extends StatelessWidget {
  const SalaryBreakdownCard({
    super.key,
    required this.breakdown,
    this.title = 'Salary Breakdown',
    this.highlightNet = true,
  });

  final SalaryBreakdown breakdown;
  final String title;
  final bool highlightNet;

  @override
  Widget build(BuildContext context) {
    final net = breakdown.netSalary;
    final Color? netColor = net < 0
        ? AppColors.error
        : (highlightNet && net > 0 ? AppColors.success : null);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.cardTitle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ValueRow(
            label: 'Gross salary',
            value: CurrencyFormatter.format(breakdown.basicSalary),
          ),
          ValueRow(
            label: 'Prorated salary',
            value: CurrencyFormatter.format(breakdown.proratedSalary),
            emphasized: true,
          ),
          const _ThinDivider(),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: Text('Deductions', style: AppTypography.label),
          ),
          ValueRow(label: 'PF', value: _deduction(breakdown.pfDeduction)),
          ValueRow(label: 'EOBI', value: _deduction(breakdown.eobiAmount)),
          ValueRow(label: 'Tax', value: _deduction(breakdown.taxAmount)),
          ValueRow(
            label: 'Total deductions',
            value: _deduction(breakdown.totalDeductions),
            emphasized: true,
          ),
          const _ThinDivider(),
          ValueRow(
            label: 'Net payable',
            value: CurrencyFormatter.format(net),
            emphasized: true,
            valueColor: netColor,
          ),
        ],
      ),
    );
  }

  /// Deductions are shown with a leading minus sign ("− PKR 1,000.00").
  static String _deduction(double amount) => amount < 0
      ? CurrencyFormatter.format(amount)
      : '− ${CurrencyFormatter.format(amount)}';
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: AppSpacing.md,
      thickness: 1,
      color: AppColors.border,
    );
  }
}

String formatRecordDate(DateTime date) =>
    DateFormat('MMM d, yyyy • h:mm a').format(date);
