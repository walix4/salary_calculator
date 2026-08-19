import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/app_database.dart';
import '../../data/datasources/salary_local_datasource.dart';
import '../../data/repositories/salary_repository_impl.dart';
import '../../domain/repositories/salary_repository.dart';
import '../../domain/usecases/calculate_salary.dart';
import '../../domain/usecases/create_salary_record.dart';
import '../../domain/usecases/delete_salary_record.dart';
import '../../domain/usecases/get_salary_record_by_id.dart';
import '../../domain/usecases/get_salary_records.dart';
import '../../domain/usecases/update_salary_record.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
SalaryLocalDataSource salaryLocalDataSource(SalaryLocalDataSourceRef ref) {
  return SalaryLocalDataSource(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
SalaryRepository salaryRepository(SalaryRepositoryRef ref) {
  return SalaryRepositoryImpl(ref.watch(salaryLocalDataSourceProvider));
}

@riverpod
CalculateSalaryUseCase calculateSalaryUseCase(CalculateSalaryUseCaseRef ref) {
  return const CalculateSalaryUseCase();
}

@riverpod
CreateSalaryRecordUseCase createSalaryRecordUseCase(
  CreateSalaryRecordUseCaseRef ref,
) {
  return CreateSalaryRecordUseCase(ref.watch(salaryRepositoryProvider));
}

@riverpod
UpdateSalaryRecordUseCase updateSalaryRecordUseCase(
  UpdateSalaryRecordUseCaseRef ref,
) {
  return UpdateSalaryRecordUseCase(ref.watch(salaryRepositoryProvider));
}

@riverpod
DeleteSalaryRecordUseCase deleteSalaryRecordUseCase(
  DeleteSalaryRecordUseCaseRef ref,
) {
  return DeleteSalaryRecordUseCase(ref.watch(salaryRepositoryProvider));
}

@riverpod
GetSalaryRecordsUseCase getSalaryRecordsUseCase(
  GetSalaryRecordsUseCaseRef ref,
) {
  return GetSalaryRecordsUseCase(ref.watch(salaryRepositoryProvider));
}

@riverpod
GetSalaryRecordByIdUseCase getSalaryRecordByIdUseCase(
  GetSalaryRecordByIdUseCaseRef ref,
) {
  return GetSalaryRecordByIdUseCase(ref.watch(salaryRepositoryProvider));
}
