import '../entities/salary_record.dart';
import '../repositories/salary_repository.dart';

class UpdateSalaryRecordUseCase {
  const UpdateSalaryRecordUseCase(this._repository);

  final SalaryRepository _repository;

  Future<bool> call(SalaryRecord record) => _repository.updateRecord(record);
}
