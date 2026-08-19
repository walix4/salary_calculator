import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/salary_breakdown.dart';

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
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            _Row(label: 'Gross (Basic) Salary', value: breakdown.basicSalary),
            _Row(
              label: 'Prorated Salary',
              value: breakdown.proratedSalary,
              emphasized: true,
            ),
            const Divider(height: 24),
            _Row(label: 'PF Deduction', value: breakdown.pfDeduction),
            _Row(label: 'EOBI Deduction', value: breakdown.eobiAmount),
            _Row(label: 'Tax Deduction', value: breakdown.taxAmount),
            _Row(
              label: 'Total Deductions',
              value: breakdown.totalDeductions,
              emphasized: true,
            ),
            const Divider(height: 24),
            _Row(
              label: 'Net Payable',
              value: breakdown.netSalary,
              emphasized: highlightNet,
              isNet: highlightNet,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.isNet = false,
  });

  final String label;
  final double value;
  final bool emphasized;
  final bool isNet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = emphasized
        ? theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isNet ? theme.colorScheme.primary : null,
          )
        : theme.textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(CurrencyFormatter.format(value), style: style),
        ],
      ),
    );
  }
}

String formatRecordDate(DateTime date) =>
    DateFormat('MMM d, yyyy • h:mm a').format(date);
