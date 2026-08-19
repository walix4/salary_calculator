import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/salary_record.dart';
import '../datasources/app_database.dart';
import '../models/salary_record_model.dart';

/// Local data source wrapping Drift DAO operations.
class SalaryLocalDataSource {
  SalaryLocalDataSource(this._database);

  final AppDatabase _database;

  Stream<List<SalaryRecord>> watchAllRecords() {
    return _database.watchAllSalaryRecords().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }

  Future<List<SalaryRecord>> getAllRecords() async {
    try {
      final models = await _database.getAllSalaryRecords();
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw DatabaseException('Failed to load salary records: $e');
    }
  }

  Future<SalaryRecord?> getRecordById(int id) async {
    try {
      final model = await _database.getSalaryRecordById(id);
      return model?.toEntity();
    } catch (e) {
      throw DatabaseException('Failed to load salary record: $e');
    }
  }

  Future<int> insertRecord(SalaryRecord record) async {
    try {
      final model = SalaryRecordModel.fromEntity(record);
      return _database.insertSalaryRecord(
        model.toCompanion(omitId: true),
      );
    } catch (e) {
      throw DatabaseException('Failed to create salary record: $e');
    }
  }

  Future<bool> updateRecord(SalaryRecord record) async {
    try {
      if (record.id == null) {
        throw DatabaseException('Cannot update record without id');
      }
      final model = SalaryRecordModel.fromEntity(record);
      return _database.updateSalaryRecord(model);
    } catch (e) {
      throw DatabaseException('Failed to update salary record: $e');
    }
  }

  Future<bool> deleteRecord(int id) async {
    try {
      final deleted = await _database.deleteSalaryRecord(id);
      return deleted > 0;
    } catch (e) {
      throw DatabaseException('Failed to delete salary record: $e');
    }
  }
}
