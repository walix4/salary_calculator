import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/salary_record_model.dart';

part 'app_database.g.dart';

@DataClassName('SalaryRecordRow')
class SalaryRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get employeeName => text().nullable()();
  RealColumn get basicSalary => real()();
  IntColumn get numberOfDaysInMonth => integer()();
  IntColumn get numberOfDaysServed => integer()();
  RealColumn get pfPercentage =>
      real().withDefault(const Constant(7.5))();
  RealColumn get eobiAmount => real()();
  RealColumn get taxAmount => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [SalaryRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<int> insertSalaryRecord(SalaryRecordsCompanion record) =>
      into(salaryRecords).insert(record);

  Future<bool> updateSalaryRecord(SalaryRecordModel record) =>
      update(salaryRecords).replace(record.toDriftRow());

  Future<int> deleteSalaryRecord(int id) =>
      (delete(salaryRecords)..where((t) => t.id.equals(id))).go();

  Future<List<SalaryRecordModel>> getAllSalaryRecords() async {
    final rows = await select(salaryRecords).get();
    return rows.map(SalaryRecordModel.fromDrift).toList();
  }

  Future<SalaryRecordModel?> getSalaryRecordById(int id) async {
    final row = await (select(salaryRecords)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : SalaryRecordModel.fromDrift(row);
  }

  Stream<List<SalaryRecordModel>> watchAllSalaryRecords() {
    return select(salaryRecords).watch().map(
          (rows) => rows.map(SalaryRecordModel.fromDrift).toList(),
        );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'salary_calculator.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
