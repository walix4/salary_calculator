import '../repositories/salary_repository.dart';

class DeleteSalaryRecordUseCase {
  const DeleteSalaryRecordUseCase(this._repository);

  final SalaryRepository _repository;

  Future<bool> call(int id) => _repository.deleteRecord(id);
}
