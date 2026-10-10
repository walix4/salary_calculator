import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/main_tab.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../salary_calculator/domain/entities/salary_record.dart';
import '../../../salary_calculator/presentation/providers/providers.dart';
import '../../../salary_calculator/presentation/providers/salary_list_notifier.dart';
import '../../../salary_calculator/presentation/screens/salary_detail_screen.dart';
import '../../../salary_calculator/presentation/screens/salary_form_screen.dart';

/// Home / overview tab: Klarna-style lavender header with a total net hero
/// card, a horizontal row of stat "widget" cards, quick actions and the most
/// recent records. All figures are derived from the stored records.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  /// Session-only dismissal of the tip banner.
  bool _tipDismissed = false;

  static const int _recentCount = 3;

  void _openForm() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const SalaryFormScreen()),
    );
  }

  void _openDetail(SalaryRecord record) {
    final id = record.id;
    if (id == null) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => SalaryDetailScreen(recordId: id)),
    );
  }

  void _openRecordsTab() {
    ref.read(mainTabProvider.notifier).state = MainTab.records;
  }

  Future<void> _refresh() =>
      ref.read(salaryListNotifierProvider.notifier).refresh();

  @override
  Widget build(BuildContext context) {
    final recordsAsync = ref.watch(salaryListNotifierProvider);
    final calculate = ref.watch(calculateSalaryUseCaseProvider);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    final List<Widget> slivers = recordsAsync.when(
      skipLoadingOnRefresh: true,
      data: (records) {
        if (records.isEmpty) {
          return [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: ContentConstraint(child: _EmptyHome(onAdd: _openForm)),
              ),
            ),
          ];
        }

        final stats = _HomeStats.from(records, (r) {
          final b = calculate(
            basicSalary: r.basicSalary,
            numberOfDaysInMonth: r.numberOfDaysInMonth,
            numberOfDaysServed: r.numberOfDaysServed,
            pfPercentage: r.pfPercentage,
            eobiAmount: r.eobiAmount,
            taxAmount: r.taxAmount,
          );
          return (net: b.netSalary, deductions: b.totalDeductions);
        });

        final recent = stats.recent(_recentCount);

        return [
          SliverToBoxAdapter(
            child: ContentConstraint(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.xs,
                  AppSpacing.screen,
                  AppSpacing.md,
                ),
                child: _TotalHeroCard(
                  total: stats.totalNet,
                  count: stats.count,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _StatCardsRow(
              stats: stats,
              onOpenLatest: () => _openDetail(stats.latest),
              onOpenRecords: _openRecordsTab,
            ),
          ),
          if (!_tipDismissed)
            SliverToBoxAdapter(
              child: ContentConstraint(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screen,
                    AppSpacing.lg,
                    AppSpacing.screen,
                    0,
                  ),
                  child: _TipBanner(
                    onDismiss: () => setState(() => _tipDismissed = true),
                  ),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: ContentConstraint(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.lg,
                  AppSpacing.screen,
                  0,
                ),
                child: _QuickActions(
                  onAdd: _openForm,
                  onAllRecords: _openRecordsTab,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentConstraint(
              child: SectionHeader(
                title: 'Recent records',
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.xl,
                  AppSpacing.xs,
                  AppSpacing.xxs,
                ),
                trailing: TextButton(
                  onPressed: _openRecordsTab,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.purple,
                  ),
                  child: const Text('View all'),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: recent.length,
            itemBuilder: (context, index) {
              final item = recent[index];
              return ContentConstraint(
                child: _RecentRow(
                  record: item.record,
                  net: item.net,
                  onTap: () => _openDetail(item.record),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.lg + bottomInset),
          ),
        ];
      },
      loading: () => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: const LoadingStateView(message: 'Loading overview…'),
          ),
        ),
      ],
      error: (error, _) => [
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: ErrorStateView(
              message: 'We couldn\'t load your records.',
              onRetry: _refresh,
            ),
          ),
        ),
      ],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        // Header stays pinned; only the content below it scrolls.
        body: Column(
          children: [
            const _GradientHeader(),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(gradient: _contentBackdrop),
                child: RefreshIndicator(
                  color: AppColors.ink,
                  backgroundColor: AppColors.background,
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: slivers,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Continues the header's lavender into white behind the scrolling content,
/// so there is no visible seam under the pinned header.
const LinearGradient _contentBackdrop = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.lavenderLight, AppColors.background],
  stops: [0, 0.45],
);

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

typedef _Computed = ({double net, double deductions});

typedef _RecordNet = ({SalaryRecord record, double net});

/// Aggregates derived from the real records list.
class _HomeStats {
  _HomeStats._({
    required this.sorted,
    required this.totalNet,
    required this.totalDeductions,
    required this.monthCount,
    required this.monthNet,
  });

  factory _HomeStats.from(
    List<SalaryRecord> records,
    _Computed Function(SalaryRecord) compute,
  ) {
    final now = DateTime.now();
    final sorted = [for (final r in records) (record: r, computed: compute(r))]
      ..sort((a, b) => b.record.updatedAt.compareTo(a.record.updatedAt));

    var totalNet = 0.0;
    var totalDeductions = 0.0;
    var monthCount = 0;
    var monthNet = 0.0;
    for (final item in sorted) {
      totalNet += item.computed.net;
      totalDeductions += item.computed.deductions;
      final updated = item.record.updatedAt.toLocal();
      if (updated.year == now.year && updated.month == now.month) {
        monthCount++;
        monthNet += item.computed.net;
      }
    }

    return _HomeStats._(
      sorted: [
        for (final item in sorted)
          (record: item.record, net: item.computed.net),
      ],
      totalNet: totalNet,
      totalDeductions: totalDeductions,
      monthCount: monthCount,
      monthNet: monthNet,
    );
  }

  /// Records with their net salary, most recently updated first.
  final List<_RecordNet> sorted;
  final double totalNet;
  final double totalDeductions;
  final int monthCount;
  final double monthNet;

  int get count => sorted.length;
  double get averageNet => count == 0 ? 0 : totalNet / count;
  SalaryRecord get latest => sorted.first.record;
  double get latestNet => sorted.first.net;

  List<_RecordNet> recent(int n) => sorted.take(n).toList();
}

String _displayName(SalaryRecord record) =>
    record.employeeName?.trim().isNotEmpty == true
    ? record.employeeName!.trim()
    : 'Unnamed employee';

String _recordsLabel(int count) => count == 1 ? '1 record' : '$count records';

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

/// Lavender gradient that runs behind the status bar, with greeting + title.
class _GradientHeader extends StatelessWidget {
  const _GradientHeader();

  static const _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.lavender, AppColors.lavenderLight],
  );

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: _gradient),
      child: SafeArea(
        top: false,
        bottom: false,
        child: ContentConstraint(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screen,
              topInset + AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrandMark(fontSize: 16),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _greeting(),
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Semantics(
                  header: true,
                  child: const Text('Overview', style: AppTypography.pageTitle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

/// White shadowed card used for the hero and the stat widgets.
BoxDecoration _floatingCardDecoration() => BoxDecoration(
  color: AppColors.card,
  borderRadius: AppRadii.xlAll,
  boxShadow: [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.06),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ],
);

class _TotalHeroCard extends StatelessWidget {
  const _TotalHeroCard({required this.total, required this.count});

  final double total;
  final int count;

  @override
  Widget build(BuildContext context) {
    final amount = CurrencyFormatter.format(total);
    final countLabel = _recordsLabel(count);
    return Semantics(
      container: true,
      label: 'Total net payable $amount across $countLabel',
      excludeSemantics: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: _floatingCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Total net payable',
                    style: AppTypography.bodySecondary,
                  ),
                ),
                SizedBox(width: AppSpacing.xs),
                IconBadge(
                  icon: Icons.account_balance_wallet_outlined,
                  size: 32,
                  background: AppColors.pinkSoft,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                amount,
                maxLines: 1,
                style: AppTypography.heroAmount.copyWith(fontSize: 32),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text('Across $countLabel', style: AppTypography.bodySecondary),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat widget cards
// ---------------------------------------------------------------------------

class _StatCardsRow extends StatelessWidget {
  const _StatCardsRow({
    required this.stats,
    required this.onOpenLatest,
    required this.onOpenRecords,
  });

  final _HomeStats stats;
  final VoidCallback onOpenLatest;
  final VoidCallback onOpenRecords;

  static final DateFormat _monthFormat = DateFormat('MMMM');

  @override
  Widget build(BuildContext context) {
    final monthName = _monthFormat.format(DateTime.now());
    final cards = [
      _StatCard(
        icon: Icons.content_cut_rounded,
        badgeColor: AppColors.pinkSoft,
        label: 'Total deductions',
        value: CurrencyFormatter.format(stats.totalDeductions),
        caption: 'PF, EOBI & tax',
        onTap: onOpenRecords,
      ),
      _StatCard(
        icon: Icons.bar_chart_rounded,
        badgeColor: AppColors.purpleSoft,
        label: 'Average net',
        value: CurrencyFormatter.format(stats.averageNet),
        caption: 'Per record',
      ),
      _StatCard(
        icon: Icons.calendar_today_rounded,
        badgeColor: AppColors.lavenderBanner,
        label: 'This month',
        value: _recordsLabel(stats.monthCount),
        caption: stats.monthCount == 0
            ? 'Nothing updated in $monthName'
            : '${CurrencyFormatter.format(stats.monthNet)} net',
        onTap: onOpenRecords,
      ),
      _StatCard(
        icon: Icons.schedule_rounded,
        badgeColor: AppColors.successSoft,
        label: 'Latest',
        value: CurrencyFormatter.format(stats.latestNet),
        caption: _displayName(stats.latest),
        onTap: onOpenLatest,
      ),
    ];

    return ContentConstraint(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = (constraints.maxWidth * 0.40).clamp(140.0, 200.0);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Room for the card shadows so they aren't clipped.
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.xs,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            clipBehavior: Clip.none,
            // IntrinsicHeight keeps every card the same height while letting
            // that height grow with the user's text scale.
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.sm),
                    SizedBox(width: cardWidth, child: cards[i]),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.badgeColor,
    required this.label,
    required this.value,
    required this.caption,
    this.onTap,
  });

  final IconData icon;
  final Color badgeColor;
  final String label;
  final String value;
  final String caption;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: onTap != null,
      label: '$label, $value, $caption',
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: _floatingCardDecoration(),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: AppRadii.xlAll,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBadge(icon: icon, background: badgeColor),
                  const SizedBox(height: AppSpacing.xl),
                  const Spacer(),
                  Text(
                    label,
                    style: AppTypography.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      maxLines: 1,
                      style: AppTypography.sectionTitle.copyWith(
                        fontFeatures: AppTypography.amount.fontFeatures,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    caption,
                    style: AppTypography.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banner, actions, recent rows, empty state
// ---------------------------------------------------------------------------

/// Dismissible lavender tip card (Klarna promo-banner style).
class _TipBanner extends StatelessWidget {
  const _TipBanner({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lavenderBanner,
        borderRadius: AppRadii.lgAll,
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xxs,
        AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBadge(
            icon: Icons.lightbulb_outline_rounded,
            background: AppColors.card,
            foreground: AppColors.purple,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Keep records tidy', style: AppTypography.cardTitle),
                const SizedBox(height: 2),
                Text(
                  'Swipe left on a record in Records to delete it.',
                  style: AppTypography.bodySecondary.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Dismiss tip',
            onPressed: onDismiss,
            icon: const Icon(
              Icons.close,
              size: AppSpacing.iconSize,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onAdd, required this.onAllRecords});

  final VoidCallback onAdd;
  final VoidCallback onAllRecords;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            label: 'Add salary',
            icon: Icons.add,
            onPressed: onAdd,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: AppButton.tonal(
            label: 'All records',
            icon: Icons.receipt_long_outlined,
            onPressed: onAllRecords,
          ),
        ),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({
    required this.record,
    required this.net,
    required this.onTap,
  });

  final SalaryRecord record;
  final double net;
  final VoidCallback onTap;

  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');

  @override
  Widget build(BuildContext context) {
    final name = _displayName(record);
    final subtitle =
        '${record.numberOfDaysServed}/${record.numberOfDaysInMonth} days'
        ' · ${_dateFormat.format(record.updatedAt)}';
    final amount = CurrencyFormatter.format(net);
    return Semantics(
      button: true,
      label: '$name, $subtitle, net $amount',
      hint: 'Opens details',
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, constraints) => AppListRow(
          title: name,
          subtitle: Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: IconBadge(letter: name.characters.first.toUpperCase()),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.42),
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
          onTap: onTap,
        ),
      ),
    );
  }
}

/// First-run state: friendly brand card plus a CTA to add a salary.
class _EmptyHome extends StatelessWidget {
  const _EmptyHome({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.xs,
        AppSpacing.screen,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            style: AppCardStyle.brand,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IconBadge(
                  icon: Icons.calculate_outlined,
                  size: 56,
                  background: AppColors.card,
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'Welcome to Salary',
                  style: AppTypography.sectionTitle,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Work out prorated pay, PF, EOBI and tax in PKR. Your '
                  'totals and recent records will show up here.',
                  style: AppTypography.bodySecondary.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Center(
            child: IconBadge(
              icon: Icons.receipt_long_outlined,
              size: 72,
              background: AppColors.purpleSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'No salary records yet',
            textAlign: TextAlign.center,
            style: AppTypography.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Add a salary calculation to start your overview.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: AppButton(
              label: 'Add your first salary',
              icon: Icons.add,
              onPressed: onAdd,
              expand: false,
            ),
          ),
        ],
      ),
    );
  }
}
