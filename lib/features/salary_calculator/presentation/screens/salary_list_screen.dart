import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/salary_list_notifier.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/salary_record_card.dart';
import 'salary_detail_screen.dart';
import 'salary_form_screen.dart';

class SalaryListScreen extends ConsumerWidget {
  const SalaryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(salaryListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Calculator'),
        centerTitle: false,
      ),
      body: recordsAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return const EmptyStateWidget(
              title: 'No salary records yet',
              message:
                  'Tap the + button to add your first salary calculation.',
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(salaryListNotifierProvider.notifier).refresh(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final record = records[index];
                return SalaryRecordCard(
                  record: record,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => SalaryDetailScreen(recordId: record.id!),
                    ),
                  ),
                  onDelete: () async {
                    await ref
                        .read(salaryListNotifierProvider.notifier)
                        .deleteRecord(record.id!);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Record deleted')),
                      );
                    }
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorStateWidget(
          message: error.toString(),
          onRetry: () =>
              ref.read(salaryListNotifierProvider.notifier).refresh(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => const SalaryFormScreen(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Salary'),
      ),
    );
  }
}
