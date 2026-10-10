import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/salary_record.dart';

/// Klarna-style transaction row for a salary record: pink initial avatar,
/// name, grey "days · date" subtitle and a right-aligned bold net amount.
///
/// Swipe end-to-start to delete; deletion is confirmed via a bottom sheet.
class SalaryRecordCard extends StatelessWidget {
  const SalaryRecordCard({
    super.key,
    required this.record,
    required this.netSalary,
    required this.onTap,
    required this.onDelete,
  });

  final SalaryRecord record;
  final double netSalary;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');

  String get _title => record.employeeName?.trim().isNotEmpty == true
      ? record.employeeName!.trim()
      : 'Unnamed employee';

  @override
  Widget build(BuildContext context) {
    final title = _title;
    final subtitle =
        '${record.numberOfDaysServed}/${record.numberOfDaysInMonth} days'
        ' · ${_dateFormat.format(record.updatedAt)}';
    final amount = CurrencyFormatter.format(netSalary);

    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showConfirmSheet(
        context,
        title: 'Delete this record?',
        message:
            'The salary record for $title will be permanently removed. '
            'This can\'t be undone.',
        confirmLabel: 'Yes, delete record',
        cancelLabel: 'No, keep it',
      ),
      onDismissed: (_) => onDelete(),
      background: const _DeleteBackground(),
      child: Semantics(
        button: true,
        label: '$title, $subtitle, net $amount',
        hint: 'Opens details. Swipe left to delete.',
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 64),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screen,
                vertical: AppSpacing.sm,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  children: [
                    IconBadge(letter: title.characters.first.toUpperCase()),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: AppTypography.cardTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: AppTypography.caption.copyWith(fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Cap the amount so long names keep some room; very large
                    // values scale down instead of overflowing.
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth * 0.45,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          amount,
                          maxLines: 1,
                          style: AppTypography.amount.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.errorSoft,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.delete_outline,
            color: AppColors.error,
            size: AppSpacing.iconSize,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'Delete',
            style: AppTypography.label.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
