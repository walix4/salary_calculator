import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/app_constants.dart';

part 'salary_form_state.freezed.dart';

/// Form input state for add/edit salary screens.
@freezed
abstract class SalaryFormState with _$SalaryFormState {
  const factory SalaryFormState({
    String? employeeName,
    @Default('') String basicSalaryText,
    @Default('30') String numberOfDaysInMonthText,
    @Default('') String numberOfDaysServedText,
    @Default('7.5') String pfPercentageText,
    @Default('0') String eobiAmountText,
    @Default('0') String taxAmountText,
  }) = _SalaryFormState;

  const SalaryFormState._();

  double? get basicSalary => double.tryParse(basicSalaryText);
  int? get numberOfDaysInMonth => int.tryParse(numberOfDaysInMonthText);
  int? get numberOfDaysServed => int.tryParse(numberOfDaysServedText);
  double get pfPercentage =>
      double.tryParse(pfPercentageText) ?? AppConstants.defaultPfPercentage;
  double get eobiAmount => double.tryParse(eobiAmountText) ?? 0;
  double get taxAmount => double.tryParse(taxAmountText) ?? 0;

  bool get hasRequiredNumericFields =>
      basicSalary != null &&
      numberOfDaysInMonth != null &&
      numberOfDaysServed != null;
}
