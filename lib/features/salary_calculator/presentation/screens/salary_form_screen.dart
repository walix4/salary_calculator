import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/salary_form_validator.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../paywall/presentation/premium_controller.dart';
import '../../../paywall/presentation/screens/paywall_screen.dart';
import '../../domain/entities/salary_record.dart';
import '../providers/salary_calculation_notifier.dart';
import '../providers/salary_form_notifier.dart';
import '../providers/salary_list_notifier.dart';
import '../widgets/salary_breakdown_card.dart';

class SalaryFormScreen extends ConsumerStatefulWidget {
  const SalaryFormScreen({super.key, this.record});

  final SalaryRecord? record;

  bool get isEditing => record != null;

  @override
  ConsumerState<SalaryFormScreen> createState() => _SalaryFormScreenState();
}

class _SalaryFormScreenState extends ConsumerState<SalaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  static const _decimalKeyboard = TextInputType.numberWithOptions(
    decimal: true,
  );

  @override
  Widget build(BuildContext context) {
    final formProvider = salaryFormNotifierProvider(
      initialRecord: widget.record,
    );
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final breakdown = ref.watch(
      salaryCalculationPreviewProvider(initialRecord: widget.record),
    );

    final daysInMonthField = AppTextField(
      label: 'Days in month',
      initialValue: formState.numberOfDaysInMonthText,
      keyboardType: TextInputType.number,
      validator: SalaryFormValidator.validateDaysInMonth,
      onChanged: formNotifier.updateDaysInMonth,
    );
    final daysServedField = AppTextField(
      label: 'Days served',
      initialValue: formState.numberOfDaysServedText,
      keyboardType: TextInputType.number,
      validator: (value) => SalaryFormValidator.validateDaysServed(
        value,
        formState.numberOfDaysInMonthText,
      ),
      onChanged: formNotifier.updateDaysServed,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screen,
                    AppSpacing.xs,
                    AppSpacing.screen,
                    AppSpacing.xl,
                  ),
                  child: ContentConstraint(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Semantics(
                          header: true,
                          child: Text(
                            widget.isEditing ? 'Edit salary' : 'Add salary',
                            style: AppTypography.pageTitle,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const Text(
                          'Enter the details to calculate net pay.',
                          style: AppTypography.bodySecondary,
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Employee
                        const SectionHeader(title: 'Employee'),
                        AppTextField(
                          label: 'Employee name (optional)',
                          initialValue: formState.employeeName,
                          prefixIcon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => formNotifier.updateEmployeeName(
                            value.isEmpty ? null : value,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Salary
                        const SectionHeader(title: 'Salary'),
                        AppTextField(
                          label: 'Basic salary (gross)',
                          initialValue: formState.basicSalaryText,
                          prefixText: 'PKR ',
                          keyboardType: _decimalKeyboard,
                          validator: SalaryFormValidator.validateBasicSalary,
                          onChanged: formNotifier.updateBasicSalary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ResponsivePair(
                          first: daysInMonthField,
                          second: daysServedField,
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Deductions
                        const SectionHeader(title: 'Deductions'),
                        AppTextField(
                          label: 'Provident fund',
                          initialValue: formState.pfPercentageText,
                          suffixText: '%',
                          helper:
                              'Default is '
                              '${AppConstants.defaultPfPercentage}%',
                          keyboardType: _decimalKeyboard,
                          validator: (value) =>
                              SalaryFormValidator.validatePercentage(
                                value,
                                label: 'PF %',
                              ),
                          onChanged: formNotifier.updatePfPercentage,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'EOBI amount',
                          initialValue: formState.eobiAmountText,
                          prefixText: 'PKR ',
                          keyboardType: _decimalKeyboard,
                          validator: (value) =>
                              SalaryFormValidator.validateNonNegativeAmount(
                                value,
                                'EOBI amount',
                              ),
                          onChanged: formNotifier.updateEobiAmount,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'Tax amount',
                          initialValue: formState.taxAmountText,
                          prefixText: 'PKR ',
                          keyboardType: _decimalKeyboard,
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              SalaryFormValidator.validateNonNegativeAmount(
                                value,
                                'Tax amount',
                              ),
                          onChanged: formNotifier.updateTaxAmount,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Live preview
                        const SectionHeader(title: 'Live preview'),
                        _NetSalaryHero(
                          amount: CurrencyFormatter.format(breakdown.netSalary),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SalaryBreakdownCard(
                          breakdown: breakdown,
                          title: 'Breakdown',
                          highlightNet: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _BottomActionBar(
              child: AppButton(
                label: widget.isEditing ? 'Update record' : 'Save record',
                isLoading: _isSaving,
                onPressed: _isSaving ? null : _save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _reachedFreeLimit() {
    if (ref.read(isPremiumProvider)) return false;
    final count = ref.read(salaryListNotifierProvider).valueOrNull?.length ?? 0;
    return count >= freeRecordLimit;
  }

  Future<void> _openPaywall() => Navigator.push(
    context,
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => PaywallScreen(
        source: 'record_limit',
        onClose: () => Navigator.pop(context),
      ),
    ),
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final formProvider = salaryFormNotifierProvider(
      initialRecord: widget.record,
    );
    final formState = ref.read(formProvider);
    if (!formState.hasRequiredNumericFields) return;

    FocusScope.of(context).unfocus();

    // Free users can save a limited number of records; editing stays free.
    // The entered values are kept, so the user can save after upgrading.
    if (!widget.isEditing && _reachedFreeLimit()) {
      await _openPaywall();
      return;
    }
    setState(() => _isSaving = true);

    final now = DateTime.now();
    final record = SalaryRecord(
      id: widget.record?.id,
      employeeName: formState.employeeName,
      basicSalary: formState.basicSalary!,
      numberOfDaysInMonth: formState.numberOfDaysInMonth!,
      numberOfDaysServed: formState.numberOfDaysServed!,
      pfPercentage: formState.pfPercentage,
      eobiAmount: formState.eobiAmount,
      taxAmount: formState.taxAmount,
      createdAt: widget.record?.createdAt ?? now,
      updatedAt: now,
    );

    try {
      if (widget.isEditing) {
        await ref
            .read(salaryListNotifierProvider.notifier)
            .updateRecord(record);
      } else {
        await ref
            .read(salaryListNotifierProvider.notifier)
            .createRecord(record);
      }

      if (mounted) {
        Navigator.pop(context);
        showAppToast(
          context,
          widget.isEditing ? 'Record updated' : 'Record saved',
          type: AppToastType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppToast(context, 'Failed to save: $e', type: AppToastType.error);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

/// Lays out two fields side by side, stacking them vertically when the
/// available width is narrow or the user has a large text scale.
class _ResponsivePair extends StatelessWidget {
  const _ResponsivePair({required this.first, required this.second});

  final Widget first;
  final Widget second;

  static const double _minSideBySideWidth = 340;
  static const double _maxSideBySideTextScale = 1.3;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    return LayoutBuilder(
      builder: (context, constraints) {
        final stack =
            constraints.maxWidth < _minSideBySideWidth ||
            textScale > _maxSideBySideTextScale;
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              first,
              const SizedBox(height: AppSpacing.md),
              second,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: first),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: second),
          ],
        );
      },
    );
  }
}

/// Pink hero card showing the live net salary.
class _NetSalaryHero extends StatelessWidget {
  const _NetSalaryHero({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Net salary $amount',
      excludeSemantics: true,
      child: AppCard(
        style: AppCardStyle.brand,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Net salary', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                amount,
                maxLines: 1,
                style: AppTypography.heroAmount.copyWith(
                  fontSize: AppTypography.heroAmount.fontSize! * 0.85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// White bar pinned under the scroll view with a hairline top border.
/// Lives inside the body (not bottomNavigationBar) so it rises above the
/// keyboard instead of being covered by it.
class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.sm,
            AppSpacing.screen,
            0,
          ),
          child: ContentConstraint(child: child),
        ),
      ),
    );
  }
}
