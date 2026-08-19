import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/salary_record.dart';
import 'providers.dart';

part 'salary_list_notifier.g.dart';

/// Manages the salary records list via a reactive Drift stream.
@riverpod
class SalaryListNotifier extends _$SalaryListNotifier {
  @override
  Stream<List<SalaryRecord>> build() {
    return ref.watch(salaryRepositoryProvider).watchAllRecords();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  Future<int> createRecord(SalaryRecord record) async {
    final id = await ref.read(createSalaryRecordUseCaseProvider)(record);
    return id;
  }

  Future<bool> updateRecord(SalaryRecord record) async {
    return ref.read(updateSalaryRecordUseCaseProvider)(record);
  }

  Future<bool> deleteRecord(int id) async {
    return ref.read(deleteSalaryRecordUseCaseProvider)(id);
  }
}
