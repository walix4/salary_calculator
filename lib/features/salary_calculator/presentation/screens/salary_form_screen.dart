import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/salary_form_validator.dart';
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

  @override
  Widget build(BuildContext context) {
    final formProvider = salaryFormNotifierProvider(
      initialRecord: widget.record,
    );
    final formState = ref.watch(formProvider);
    final breakdown = ref.watch(
      salaryCalculationPreviewProvider(initialRecord: widget.record),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Salary' : 'Add Salary'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: formState.employeeName,
              decoration: const InputDecoration(
                labelText: 'Employee Name (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => ref
                  .read(formProvider.notifier)
                  .updateEmployeeName(value.isEmpty ? null : value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.basicSalaryText,
              decoration: const InputDecoration(
                labelText: 'Basic Salary (Gross)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: SalaryFormValidator.validateBasicSalary,
              onChanged: (value) =>
                  ref.read(formProvider.notifier).updateBasicSalary(value),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: formState.numberOfDaysInMonthText,
                    decoration: const InputDecoration(
                      labelText: 'Days in Month',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: SalaryFormValidator.validateDaysInMonth,
                    onChanged: (value) => ref
                        .read(formProvider.notifier)
                        .updateDaysInMonth(value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: formState.numberOfDaysServedText,
                    decoration: const InputDecoration(
                      labelText: 'Days Served',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => SalaryFormValidator.validateDaysServed(
                      value,
                      formState.numberOfDaysInMonthText,
                    ),
                    onChanged: (value) => ref
                        .read(formProvider.notifier)
                        .updateDaysServed(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.pfPercentageText,
              decoration: InputDecoration(
                labelText: 'PF % (default ${AppConstants.defaultPfPercentage})',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.percent),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  SalaryFormValidator.validatePercentage(value, label: 'PF %'),
              onChanged: (value) => ref
                  .read(formProvider.notifier)
                  .updatePfPercentage(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.eobiAmountText,
              decoration: const InputDecoration(
                labelText: 'EOBI Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) => SalaryFormValidator.validateNonNegativeAmount(
                value,
                'EOBI amount',
              ),
              onChanged: (value) =>
                  ref.read(formProvider.notifier).updateEobiAmount(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: formState.taxAmountText,
              decoration: const InputDecoration(
                labelText: 'Tax Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt_outlined),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) => SalaryFormValidator.validateNonNegativeAmount(
                value,
                'Tax amount',
              ),
              onChanged: (value) =>
                  ref.read(formProvider.notifier).updateTaxAmount(value),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Net Salary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                    Text(
                      CurrencyFormatter.format(breakdown.netSalary),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SalaryBreakdownCard(
              breakdown: breakdown,
              title: 'Live Preview',
              highlightNet: false,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Record' : 'Save Record'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final formProvider = salaryFormNotifierProvider(
      initialRecord: widget.record,
    );
    final formState = ref.read(formProvider);
    if (!formState.hasRequiredNumericFields) return;

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
        await ref.read(salaryListNotifierProvider.notifier).updateRecord(record);
      } else {
        await ref.read(salaryListNotifierProvider.notifier).createRecord(record);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.isEditing ? 'Record updated' : 'Record saved',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
