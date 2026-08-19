import '../entities/salary_record.dart';
import '../repositories/salary_repository.dart';

class CreateSalaryRecordUseCase {
  const CreateSalaryRecordUseCase(this._repository);

  final SalaryRepository _repository;

  Future<int> call(SalaryRecord record) => _repository.createRecord(record);
}
