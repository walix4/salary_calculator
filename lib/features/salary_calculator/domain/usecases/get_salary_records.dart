import '../entities/salary_record.dart';
import '../repositories/salary_repository.dart';

class GetSalaryRecordsUseCase {
  const GetSalaryRecordsUseCase(this._repository);

  final SalaryRepository _repository;

  Future<List<SalaryRecord>> call() => _repository.getAllRecords();
}
