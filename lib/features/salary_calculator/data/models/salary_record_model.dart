import 'package:drift/drift.dart';

import '../../domain/entities/salary_record.dart';
import '../datasources/app_database.dart';

/// Maps between Drift rows and domain entities.
class SalaryRecordModel {
  SalaryRecordModel({
    required this.id,
    this.employeeName,
    required this.basicSalary,
    required this.numberOfDaysInMonth,
    required this.numberOfDaysServed,
    required this.pfPercentage,
    required this.eobiAmount,
    required this.taxAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String? employeeName;
  final double basicSalary;
  final int numberOfDaysInMonth;
  final int numberOfDaysServed;
  final double pfPercentage;
  final double eobiAmount;
  final double taxAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SalaryRecordModel.fromDrift(SalaryRecordRow row) {
    return SalaryRecordModel(
      id: row.id,
      employeeName: row.employeeName,
      basicSalary: row.basicSalary,
      numberOfDaysInMonth: row.numberOfDaysInMonth,
      numberOfDaysServed: row.numberOfDaysServed,
      pfPercentage: row.pfPercentage,
      eobiAmount: row.eobiAmount,
      taxAmount: row.taxAmount,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  SalaryRecord toEntity() {
    return SalaryRecord(
      id: id,
      employeeName: employeeName,
      basicSalary: basicSalary,
      numberOfDaysInMonth: numberOfDaysInMonth,
      numberOfDaysServed: numberOfDaysServed,
      pfPercentage: pfPercentage,
      eobiAmount: eobiAmount,
      taxAmount: taxAmount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  SalaryRecordsCompanion toCompanion({bool omitId = false}) {
    return SalaryRecordsCompanion(
      id: omitId ? const Value.absent() : Value(id),
      employeeName: Value(employeeName),
      basicSalary: Value(basicSalary),
      numberOfDaysInMonth: Value(numberOfDaysInMonth),
      numberOfDaysServed: Value(numberOfDaysServed),
      pfPercentage: Value(pfPercentage),
      eobiAmount: Value(eobiAmount),
      taxAmount: Value(taxAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  SalaryRecordRow toDriftRow() {
    return SalaryRecordRow(
      id: id,
      employeeName: employeeName,
      basicSalary: basicSalary,
      numberOfDaysInMonth: numberOfDaysInMonth,
      numberOfDaysServed: numberOfDaysServed,
      pfPercentage: pfPercentage,
      eobiAmount: eobiAmount,
      taxAmount: taxAmount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static SalaryRecordModel fromEntity(SalaryRecord entity) {
    return SalaryRecordModel(
      id: entity.id ?? 0,
      employeeName: entity.employeeName,
      basicSalary: entity.basicSalary,
      numberOfDaysInMonth: entity.numberOfDaysInMonth,
      numberOfDaysServed: entity.numberOfDaysServed,
      pfPercentage: entity.pfPercentage,
      eobiAmount: entity.eobiAmount,
      taxAmount: entity.taxAmount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
