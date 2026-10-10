import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/salary_breakdown.dart';
import '../../domain/entities/salary_record.dart';
import '../providers/providers.dart';
import '../providers/salary_list_notifier.dart';
import '../widgets/salary_breakdown_card.dart';
import 'salary_form_screen.dart';

class SalaryDetailScreen extends ConsumerWidget {
  const SalaryDetailScreen({super.key, required this.recordId});

  final int recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordAsync = ref.watch(_salaryRecordProvider(recordId));
    final record = recordAsync.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary details'),
        actions: [
          if (record != null)
            IconButton(
              tooltip: 'Edit record',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _openEdit(context, ref, record),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: recordAsync.when(
          data: (record) {
            if (record == null) {
              return const EmptyStateView(
                icon: Icons.search_off,
                title: 'Record not found',
                message: 'This salary record may have been deleted.',
              );
            }
            final breakdown = ref.read(calculateSalaryUseCaseProvider)(
              basicSalary: record.basicSalary,
              numberOfDaysInMonth: record.numberOfDaysInMonth,
              numberOfDaysServed: record.numberOfDaysServed,
              pfPercentage: record.pfPercentage,
              eobiAmount: record.eobiAmount,
              taxAmount: record.taxAmount,
            );
            return _DetailBody(
              record: record,
              breakdown: breakdown,
              onEdit: () => _openEdit(context, ref, record),
              onDelete: () => _confirmDelete(context, ref, record),
            );
          },
          loading: () => const LoadingStateView(),
          error: (error, _) => ErrorStateView(
            message: error.toString(),
            onRetry: () => ref.invalidate(_salaryRecordProvider(recordId)),
          ),
        ),
      ),
    );
  }

  Future<void> _openEdit(
    BuildContext context,
    WidgetRef ref,
    SalaryRecord record,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => SalaryFormScreen(record: record)),
    );
    // The family provider caches the fetched record; refresh it so edits made
    // on the form screen are reflected here.
    if (context.mounted) {
      ref.invalidate(_salaryRecordProvider(recordId));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SalaryRecord record,
  ) async {
    final confirmed = await showConfirmSheet(
      context,
      title: 'Delete this record?',
      message: 'This salary record will be permanently removed.',
      confirmLabel: 'Yes, delete record',
      cancelLabel: 'No, keep it',
    );

    if (!confirmed || !context.mounted) return;

    await ref
        .read(salaryListNotifierProvider.notifier)
        .deleteRecord(record.id!);
    if (!context.mounted) return;

    // Capture a context that outlives this route (the navigator sits below the
    // app-level ScaffoldMessenger) so the toast can be shown after popping.
    final navigator = Navigator.of(context);
    final toastContext = navigator.context;
    navigator.pop();
    if (toastContext.mounted) {
      showAppToast(toastContext, 'Record deleted');
    }
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.record,
    required this.breakdown,
    required this.onEdit,
    required this.onDelete,
  });

  final SalaryRecord record;
  final SalaryBreakdown breakdown;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final trimmedName = record.employeeName?.trim() ?? '';
    final name = trimmedName.isNotEmpty ? trimmedName : 'Unnamed Employee';
    final initial = trimmedName.isNotEmpty
        ? trimmedName.characters.first.toUpperCase()
        : '?';

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        ContentConstraint(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroHeader(
                initial: initial,
                name: name,
                netSalary: breakdown.netSalary,
                meta: 'Updated ${formatRecordDate(record.updatedAt)}',
              ),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        'Details',
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ValueRow(
                      label: 'Days served',
                      value:
                          '${record.numberOfDaysServed} / '
                          '${record.numberOfDaysInMonth} days',
                    ),
                    ValueRow(
                      label: 'PF percentage',
                      value: '${_formatPercent(record.pfPercentage)}%',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SalaryBreakdownCard(breakdown: breakdown),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Manage'),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    AppListRow(
                      title: 'Edit record',
                      leading: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.ink,
                        size: AppSpacing.iconSize,
                      ),
                      showChevron: true,
                      onTap: onEdit,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: AppSpacing.screen,
                      endIndent: AppSpacing.screen,
                      color: AppColors.border,
                    ),
                    _DestructiveRow(label: 'Delete record', onTap: onDelete),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Drops a trailing ".0" so 10.0 renders as "10" but 8.33 stays "8.33".
  static String _formatPercent(double value) => value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toString();
}

/// Centered avatar, name, "Net payable" label, hero amount and meta line.
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.initial,
    required this.name,
    required this.netSalary,
    required this.meta,
  });

  final String initial;
  final String name;
  final double netSalary;
  final String meta;

  @override
  Widget build(BuildContext context) {
    final amountColor = netSalary < 0 ? AppColors.error : null;

    return Semantics(
      container: true,
      child: Column(
        children: [
          IconBadge(letter: initial, size: 56),
          const SizedBox(height: AppSpacing.sm),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Net payable',
            textAlign: TextAlign.center,
            style: AppTypography.label,
          ),
          const SizedBox(height: AppSpacing.xxs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              CurrencyFormatter.format(netSalary),
              maxLines: 1,
              style: AppTypography.heroAmount.copyWith(color: amountColor),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            meta,
            textAlign: TextAlign.center,
            style: AppTypography.bodySecondary,
          ),
        ],
      ),
    );
  }
}

/// Manage-section row for a destructive action: red trash icon + red label.
class _DestructiveRow extends StatelessWidget {
  const _DestructiveRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screen,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: AppSpacing.iconSize,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
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

final _salaryRecordProvider = FutureProvider.autoDispose
    .family<SalaryRecord?, int>((ref, id) {
      return ref.watch(getSalaryRecordByIdUseCaseProvider)(id);
    });
