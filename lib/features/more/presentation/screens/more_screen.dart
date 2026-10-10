import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../onboarding/presentation/onboarding_controller.dart';

/// "More" tab: information about the calculation, privacy and app actions.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  static const String _versionLabel = 'Version 1.0.0';

  static const EdgeInsets _sectionHeaderPadding = EdgeInsets.only(
    top: AppSpacing.xl,
    bottom: AppSpacing.sm,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.paddingOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        // Title stays pinned; only the sections below it scroll.
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ContentConstraint(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  padding.top + AppSpacing.lg,
                  AppSpacing.screen,
                  0,
                ),
                child: Semantics(
                  header: true,
                  child: const Text('More', style: AppTypography.pageTitle),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  bottom: padding.bottom + AppSpacing.lg,
                ),
                children: [
                  ContentConstraint(
                    child: Padding(
                      padding: AppSpacing.screenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(
                            title: 'About the calculation',
                            padding: _sectionHeaderPadding,
                          ),
                          _Group(
                            children: [
                              AppListRow(
                                title: 'How net salary is calculated',
                                subtitle: const Text(
                                  'Proration, provident fund and deductions',
                                ),
                                leading: const _RowIcon(
                                  Icons.calculate_outlined,
                                ),
                                showChevron: true,
                                onTap: () => _showFormulaSheet(context),
                              ),
                              const AppListRow(
                                title: 'Currency',
                                subtitle: Text(
                                  'Pakistani Rupee (${AppConstants.currencyCode})',
                                ),
                                leading: _RowIcon(Icons.payments_outlined),
                              ),
                            ],
                          ),
                          const SectionHeader(
                            title: 'App',
                            padding: _sectionHeaderPadding,
                          ),
                          _Group(
                            children: [
                              AppListRow(
                                title: 'View intro again',
                                subtitle: const Text(
                                  'Replay the welcome screens',
                                ),
                                leading: const _RowIcon(Icons.replay_outlined),
                                showChevron: true,
                                onTap: () => ref
                                    .read(onboardingControllerProvider.notifier)
                                    .reset(),
                              ),
                              AppListRow(
                                title: 'Privacy',
                                subtitle: const Text(
                                  'How your records are stored',
                                ),
                                leading: const _RowIcon(Icons.lock_outline),
                                showChevron: true,
                                onTap: () => _showPrivacySheet(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          const Center(child: BrandMark(fontSize: 16)),
                          const SizedBox(height: AppSpacing.xs),
                          const Center(
                            child: Text(
                              _versionLabel,
                              style: AppTypography.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showFormulaSheet(BuildContext context) {
    final pfBase = _percent(AppConstants.pfBasePercentage);
    final pfDefault = _percent(AppConstants.defaultPfPercentage);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _InfoSheet(
        title: 'How net salary is calculated',
        children: [
          const _FormulaStep(
            label: 'Prorated salary',
            formula: 'Basic salary ÷ days in month × days served',
          ),
          _FormulaStep(
            label: 'Provident fund (PF)',
            formula:
                'Prorated salary × $pfBase × PF rate '
                '(default $pfDefault)',
          ),
          const _FormulaStep(
            label: 'Net salary',
            formula: 'Prorated salary − PF − EOBI − tax',
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'EOBI and tax are entered as fixed amounts for each record. '
            'Days served can\'t exceed the days in the month.',
            style: AppTypography.bodySecondary,
          ),
        ],
      ),
    );
  }

  static void _showPrivacySheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _InfoSheet(
        title: 'Privacy',
        children: [
          Text(
            'Your salary records are stored only on this device, in a local '
            'database. There\'s no account and nothing is sent anywhere.',
            style: AppTypography.body,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Deleting the app removes all of your records.',
            style: AppTypography.bodySecondary,
          ),
        ],
      ),
    );
  }

  /// 55.0 → "55%", 7.5 → "7.5%".
  static String _percent(double value) {
    final text = value == value.truncateToDouble()
        ? value.toStringAsFixed(0)
        : value.toString();
    return '$text%';
  }
}

/// Grey rounded group holding a set of list rows.
class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Column(children: children),
    );
  }
}

class _RowIcon extends StatelessWidget {
  const _RowIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 24, color: AppColors.ink);
  }
}

class _InfoSheet extends StatelessWidget {
  const _InfoSheet({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: ContentConstraint(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                header: true,
                child: Text(title, style: AppTypography.sectionTitle),
              ),
              const SizedBox(height: AppSpacing.md),
              ...children,
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Got it',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormulaStep extends StatelessWidget {
  const _FormulaStep({required this.label, required this.formula});

  final String label;
  final String formula;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.label),
              const SizedBox(height: AppSpacing.xxs),
              Text(formula, style: AppTypography.cardTitle),
            ],
          ),
        ),
      ),
    );
  }
}
