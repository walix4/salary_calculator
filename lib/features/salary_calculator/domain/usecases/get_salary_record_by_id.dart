import '../entities/salary_record.dart';
import '../repositories/salary_repository.dart';

class GetSalaryRecordByIdUseCase {
  const GetSalaryRecordByIdUseCase(this._repository);

  final SalaryRepository _repository;

  Future<SalaryRecord?> call(int id) => _repository.getRecordById(id);
}
