import 'package:freezed_annotation/freezed_annotation.dart';

part 'salary_breakdown.freezed.dart';

/// Computed salary breakdown returned by the calculation use case.
@freezed
abstract class SalaryBreakdown with _$SalaryBreakdown {
  const factory SalaryBreakdown({
    required double basicSalary,
    required double proratedSalary,
    required double pfDeduction,
    required double eobiAmount,
    required double taxAmount,
    required double totalDeductions,
    required double netSalary,
  }) = _SalaryBreakdown;
}
