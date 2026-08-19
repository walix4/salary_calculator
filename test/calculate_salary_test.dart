import 'package:flutter_test/flutter_test.dart';

import 'package:salary_calculator/features/salary_calculator/domain/usecases/calculate_salary.dart';

void main() {
  const useCase = CalculateSalaryUseCase();

  group('CalculateSalaryUseCase', () {
    test('calculates full month salary with deductions', () {
      final result = useCase(
        basicSalary: 100000,
        numberOfDaysInMonth: 30,
        numberOfDaysServed: 30,
        pfPercentage: 7.5,
        eobiAmount: 500,
        taxAmount: 2000,
      );

      expect(result.proratedSalary, closeTo(100000, 0.01));
      expect(result.pfDeduction, closeTo(4125, 0.01));
      expect(result.totalDeductions, closeTo(6625, 0.01));
      expect(result.netSalary, closeTo(93375, 0.01));
    });

    test('prorates salary when days served is less than month days', () {
      final result = useCase(
        basicSalary: 30000,
        numberOfDaysInMonth: 30,
        numberOfDaysServed: 15,
        pfPercentage: 7.5,
        eobiAmount: 0,
        taxAmount: 0,
      );

      expect(result.proratedSalary, closeTo(15000, 0.01));
      expect(result.pfDeduction, closeTo(618.75, 0.01));
      expect(result.netSalary, closeTo(14381.25, 0.01));
    });

    test('returns zero prorated salary when days served is 0', () {
      final result = useCase(
        basicSalary: 50000,
        numberOfDaysInMonth: 30,
        numberOfDaysServed: 0,
        pfPercentage: 7.5,
        eobiAmount: 300,
        taxAmount: 100,
      );

      expect(result.proratedSalary, 0);
      expect(result.pfDeduction, 0);
      expect(result.totalDeductions, closeTo(400, 0.01));
      expect(result.netSalary, closeTo(-400, 0.01));
    });

    test('treats days served equal to days in month as full salary', () {
      final result = useCase(
        basicSalary: 62000,
        numberOfDaysInMonth: 31,
        numberOfDaysServed: 31,
        pfPercentage: 7.5,
        eobiAmount: 0,
        taxAmount: 0,
      );

      expect(result.proratedSalary, closeTo(62000, 0.01));
      expect(result.netSalary, closeTo(59442.5, 0.01));
    });

    test('clamps days served above month days to month days', () {
      final result = useCase(
        basicSalary: 30000,
        numberOfDaysInMonth: 28,
        numberOfDaysServed: 35,
        pfPercentage: 7.5,
        eobiAmount: 0,
        taxAmount: 0,
      );

      expect(result.proratedSalary, closeTo(30000, 0.01));
    });

    test('handles zero days in month without division error', () {
      final result = useCase(
        basicSalary: 30000,
        numberOfDaysInMonth: 0,
        numberOfDaysServed: 10,
        pfPercentage: 7.5,
        eobiAmount: 100,
        taxAmount: 50,
      );

      expect(result.proratedSalary, 0);
      expect(result.pfDeduction, 0);
      expect(result.totalDeductions, closeTo(150, 0.01));
    });
  });
}
