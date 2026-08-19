import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/salary_record.dart';
import 'salary_form_state.dart';

part 'salary_form_notifier.g.dart';

/// Holds form field values for add/edit salary screens.
@riverpod
class SalaryFormNotifier extends _$SalaryFormNotifier {
  @override
  SalaryFormState build({SalaryRecord? initialRecord}) {
    if (initialRecord != null) {
      return SalaryFormState(
        employeeName: initialRecord.employeeName,
        basicSalaryText: _formatNum(initialRecord.basicSalary),
        numberOfDaysInMonthText: initialRecord.numberOfDaysInMonth.toString(),
        numberOfDaysServedText: initialRecord.numberOfDaysServed.toString(),
        pfPercentageText: _formatNum(initialRecord.pfPercentage),
        eobiAmountText: _formatNum(initialRecord.eobiAmount),
        taxAmountText: _formatNum(initialRecord.taxAmount),
      );
    }
    return const SalaryFormState();
  }

  void updateEmployeeName(String? value) {
    state = state.copyWith(employeeName: value);
  }

  void updateBasicSalary(String value) {
    state = state.copyWith(basicSalaryText: value);
  }

  void updateDaysInMonth(String value) {
    state = state.copyWith(numberOfDaysInMonthText: value);
  }

  void updateDaysServed(String value) {
    state = state.copyWith(numberOfDaysServedText: value);
  }

  void updatePfPercentage(String value) {
    state = state.copyWith(pfPercentageText: value);
  }

  void updateEobiAmount(String value) {
    state = state.copyWith(eobiAmountText: value);
  }

  void updateTaxAmount(String value) {
    state = state.copyWith(taxAmountText: value);
  }

  String _formatNum(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}
