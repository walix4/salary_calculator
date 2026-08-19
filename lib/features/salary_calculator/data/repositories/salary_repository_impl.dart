import '../../domain/entities/salary_record.dart';
import '../../domain/repositories/salary_repository.dart';
import '../datasources/salary_local_datasource.dart';

class SalaryRepositoryImpl implements SalaryRepository {
  SalaryRepositoryImpl(this._localDataSource);

  final SalaryLocalDataSource _localDataSource;

  @override
  Stream<List<SalaryRecord>> watchAllRecords() =>
      _localDataSource.watchAllRecords();

  @override
  Future<List<SalaryRecord>> getAllRecords() =>
      _localDataSource.getAllRecords();

  @override
  Future<SalaryRecord?> getRecordById(int id) =>
      _localDataSource.getRecordById(id);

  @override
  Future<int> createRecord(SalaryRecord record) =>
      _localDataSource.insertRecord(record);

  @override
  Future<bool> updateRecord(SalaryRecord record) =>
      _localDataSource.updateRecord(record);

  @override
  Future<bool> deleteRecord(int id) => _localDataSource.deleteRecord(id);
}
