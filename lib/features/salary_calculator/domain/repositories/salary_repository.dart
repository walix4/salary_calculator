import '../entities/salary_record.dart';

/// Contract for salary record persistence and queries.
abstract class SalaryRepository {
  Stream<List<SalaryRecord>> watchAllRecords();

  Future<List<SalaryRecord>> getAllRecords();

  Future<SalaryRecord?> getRecordById(int id);

  Future<int> createRecord(SalaryRecord record);

  Future<bool> updateRecord(SalaryRecord record);

  Future<bool> deleteRecord(int id);
}
