import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/salary_breakdown.dart';
import '../../domain/entities/salary_record.dart';
import 'providers.dart';
import 'salary_form_notifier.dart';

part 'salary_calculation_notifier.g.dart';

/// Live salary calculation preview derived from form state.
@riverpod
SalaryBreakdown salaryCalculationPreview(
  SalaryCalculationPreviewRef ref, {
  SalaryRecord? initialRecord,
}) {
  final formState = ref.watch(
    salaryFormNotifierProvider(initialRecord: initialRecord),
  );
  return ref.read(calculateSalaryUseCaseProvider)(
    basicSalary: formState.basicSalary ?? 0,
    numberOfDaysInMonth: formState.numberOfDaysInMonth ?? 30,
    numberOfDaysServed: formState.numberOfDaysServed ?? 0,
    pfPercentage: formState.pfPercentage,
    eobiAmount: formState.eobiAmount,
    taxAmount: formState.taxAmount,
  );
}
