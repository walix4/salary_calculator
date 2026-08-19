/// Validates salary form field values.
class SalaryFormValidator {
  SalaryFormValidator._();

  static String? validateBasicSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Basic salary is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed < 0) {
      return 'Salary cannot be negative';
    }
    return null;
  }

  static String? validateDaysInMonth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Days in month is required';
    }
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid whole number';
    }
    if (parsed < 28 || parsed > 31) {
      return 'Enter a value between 28 and 31';
    }
    return null;
  }

  static String? validateDaysServed(String? value, String daysInMonthText) {
    if (value == null || value.trim().isEmpty) {
      return 'Days served is required';
    }
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid whole number';
    }
    if (parsed < 0) {
      return 'Days served cannot be negative';
    }
    final daysInMonth = int.tryParse(daysInMonthText);
    if (daysInMonth != null && parsed > daysInMonth) {
      return 'Days served cannot exceed days in month ($daysInMonth)';
    }
    return null;
  }

  static String? validatePercentage(String? value, {String label = 'PF %'}) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed < 0 || parsed > 100) {
      return '$label must be between 0 and 100';
    }
    return null;
  }

  static String? validateNonNegativeAmount(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed < 0) {
      return '$label cannot be negative';
    }
    return null;
  }
}
