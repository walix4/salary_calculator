import '../../../../core/constants/app_constants.dart';
import '../entities/salary_breakdown.dart';

/// Pure salary calculation logic — fully unit-testable with no Flutter deps.
class CalculateSalaryUseCase {
  const CalculateSalaryUseCase();

  SalaryBreakdown call({
    required double basicSalary,
    required int numberOfDaysInMonth,
    required int numberOfDaysServed,
    required double pfPercentage,
    required double eobiAmount,
    required double taxAmount,
  }) {
    if (numberOfDaysInMonth <= 0) {
      return _zeroBreakdown(
        basicSalary: basicSalary,
        eobiAmount: eobiAmount,
        taxAmount: taxAmount,
      );
    }

    final safeDaysServed = numberOfDaysServed.clamp(0, numberOfDaysInMonth);
    final proratedSalary =
        (basicSalary / numberOfDaysInMonth) * safeDaysServed;
    final pfBase =
        proratedSalary * (AppConstants.pfBasePercentage / 100);
    final pfDeduction = pfBase * (pfPercentage / 100);
    final totalDeductions = pfDeduction + eobiAmount + taxAmount;
    final netSalary = proratedSalary - totalDeductions;

    return SalaryBreakdown(
      basicSalary: basicSalary,
      proratedSalary: proratedSalary,
      pfDeduction: pfDeduction,
      eobiAmount: eobiAmount,
      taxAmount: taxAmount,
      totalDeductions: totalDeductions,
      netSalary: netSalary,
    );
  }

  SalaryBreakdown _zeroBreakdown({
    required double basicSalary,
    required double eobiAmount,
    required double taxAmount,
  }) {
    return SalaryBreakdown(
      basicSalary: basicSalary,
      proratedSalary: 0,
      pfDeduction: 0,
      eobiAmount: eobiAmount,
      taxAmount: taxAmount,
      totalDeductions: eobiAmount + taxAmount,
      netSalary: -(eobiAmount + taxAmount),
    );
  }
}
