import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/app_constants.dart';

part 'salary_record.freezed.dart';

/// Domain entity representing a persisted salary record.
@freezed
abstract class SalaryRecord with _$SalaryRecord {
  const factory SalaryRecord({
    int? id,
    String? employeeName,
    required double basicSalary,
    required int numberOfDaysInMonth,
    required int numberOfDaysServed,
    @Default(AppConstants.defaultPfPercentage) double pfPercentage,
    required double eobiAmount,
    required double taxAmount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SalaryRecord;
}
