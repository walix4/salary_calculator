import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/salary_record.dart';
import '../providers/providers.dart';
import '../providers/salary_list_notifier.dart';
import '../widgets/salary_record_card.dart';
import 'salary_detail_screen.dart';
import 'salary_form_screen.dart';

class SalaryListScreen extends ConsumerStatefulWidget {
  const SalaryListScreen({super.key});

  @override
  ConsumerState<SalaryListScreen> createState() => _SalaryListScreenState();
}

class _SalaryListScreenState extends ConsumerState<SalaryListScreen> {
  /// Records swiped away whose deletion is in flight. Filtered out locally so
  /// a dismissed [Dismissible] is removed from the tree immediately, before
  /// the database stream emits the updated list.
  final Set<int> _pendingDeletes = {};

  /// Gap between the floating bottom nav and the "Add salary" button.
  static const double _addButtonGap = AppSpacing.sm;

  /// Room below the last row so it clears the "Add salary" button as well as
  /// the floating nav (already included in the bottom padding).
  static const double _addButtonClearance =
      _addButtonGap + AppSpacing.buttonHeight + AppSpacing.lg;

  void _openForm() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const SalaryFormScreen()),
    );
  }

  void _openDetail(SalaryRecord record) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => SalaryDetailScreen(recordId: record.id!),
      ),
    );
  }

  Future<void> _refresh() =>
      ref.read(salaryListNotifierProvider.notifier).refresh();

  Future<void> _delete(SalaryRecord record) async {
    final id = record.id!;
    setState(() => _pendingDeletes.add(id));
    var deleted = false;
    try {
      deleted = await ref
          .read(salaryListNotifierProvider.notifier)
          .deleteRecord(id);
    } catch (_) {
      deleted = false;
    }
    if (!mounted) return;
    if (deleted) {
      showAppToast(context, 'Record deleted');
    } else {
      setState(() => _pendingDeletes.remove(id));
      showAppToast(
        context,
        'Couldn\'t delete record. Please try again.',
        type: AppToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordsAsync = ref.watch(salaryListNotifierProvider);
    final calculate = ref.watch(calculateSalaryUseCaseProvider);
    // Includes the floating nav height because the shell uses extendBody.
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    final records = recordsAsync.valueOrNull
        ?.where((r) => !_pendingDeletes.contains(r.id))
        .toList();
    final hasRecords = records != null && records.isNotEmpty;

    final List<Widget> contentSlivers = recordsAsync.when(
      data: (_) {
        final visible = records ?? const <SalaryRecord>[];
        if (visible.isEmpty) {
          return [
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: EmptyStateView(
                  title: 'No salary records yet',
                  message:
                      'Add your first salary calculation to see it listed '
                      'here.',
                  actionLabel: 'Add salary',
                  onAction: _openForm,
                ),
              ),
            ),
          ];
        }

        return [
          SliverList.builder(
            itemCount: visible.length,
            itemBuilder: (context, index) {
              final record = visible[index];
              final net = calculate(
                basicSalary: record.basicSalary,
                numberOfDaysInMonth: record.numberOfDaysInMonth,
                numberOfDaysServed: record.numberOfDaysServed,
                pfPercentage: record.pfPercentage,
                eobiAmount: record.eobiAmount,
                taxAmount: record.taxAmount,
              ).netSalary;
              return ContentConstraint(
                child: SalaryRecordCard(
                  key: ValueKey(record.id),
                  record: record,
                  netSalary: net,
                  onTap: () => _openDetail(record),
                  onDelete: () => _delete(record),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: _addButtonClearance + bottomInset),
          ),
        ];
      },
      loading: () => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: const LoadingStateView(message: 'Loading records…'),
          ),
        ),
      ],
      error: (error, _) => [
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: ErrorStateView(message: error.toString(), onRetry: _refresh),
          ),
        ),
      ],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Header stays pinned; only the list below it scrolls.
            Column(
              children: [
                _Header(count: records?.length),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.ink,
                    backgroundColor: AppColors.background,
                    onRefresh: _refresh,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: contentSlivers,
                    ),
                  ),
                ),
              ],
            ),
            // Positioned manually (not a Scaffold FAB) so it always sits just
            // above the shell's floating bottom nav.
            if (hasRecords)
              Positioned(
                left: AppSpacing.screen,
                right: AppSpacing.screen,
                bottom: bottomInset + _addButtonGap,
                child: Center(child: _AddButton(onPressed: _openForm)),
              ),
          ],
        ),
      ),
    );
  }
}

/// Plain white header with a large title and a grey record count.
class _Header extends StatelessWidget {
  const _Header({this.count});

  /// Number of saved records, or null while loading / on error.
  final int? count;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final caption = switch (count) {
      null => null,
      0 => 'No saved calculations',
      1 => '1 saved calculation',
      final n => '$n saved calculations',
    };
    return ContentConstraint(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screen,
          topInset + AppSpacing.lg,
          AppSpacing.screen,
          AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: const Text('Records', style: AppTypography.pageTitle),
            ),
            if (caption != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(caption, style: AppTypography.bodySecondary),
            ],
          ],
        ),
      ),
    );
  }
}

/// Floating primary pill with a soft shadow so it reads above list content.
class _AddButton extends StatelessWidget {
  const _AddButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadii.pillAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Semantics(
        hint: 'Opens the salary form',
        child: AppButton(
          label: 'Add salary',
          icon: Icons.add,
          expand: false,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
