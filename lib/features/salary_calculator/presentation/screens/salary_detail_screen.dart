import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/salary_record.dart';
import '../providers/providers.dart';
import '../providers/salary_list_notifier.dart';
import '../widgets/salary_breakdown_card.dart';
import 'salary_form_screen.dart';

class SalaryDetailScreen extends ConsumerWidget {
  const SalaryDetailScreen({super.key, required this.recordId});

  final int recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordAsync = ref.watch(_salaryRecordProvider(recordId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Details'),
        actions: [
          recordAsync.whenOrNull(
            data: (record) => IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => SalaryFormScreen(record: record),
                ),
              ),
            ),
          ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: recordAsync.when(
        data: (record) {
          if (record == null) {
            return const Center(child: Text('Record not found'));
          }

          final breakdown = ref.read(calculateSalaryUseCaseProvider)(
            basicSalary: record.basicSalary,
            numberOfDaysInMonth: record.numberOfDaysInMonth,
            numberOfDaysServed: record.numberOfDaysServed,
            pfPercentage: record.pfPercentage,
            eobiAmount: record.eobiAmount,
            taxAmount: record.taxAmount,
          );

          final name = record.employeeName?.trim().isNotEmpty == true
              ? record.employeeName!
              : 'Unnamed Employee';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Updated ${formatRecordDate(record.updatedAt)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              _InfoTile(
                label: 'Days Served',
                value:
                    '${record.numberOfDaysServed} / ${record.numberOfDaysInMonth}',
              ),
              _InfoTile(
                label: 'PF Percentage',
                value: '${record.pfPercentage}%',
              ),
              const SizedBox(height: 16),
              SalaryBreakdownCard(breakdown: breakdown),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => _confirmDelete(context, ref, record),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Record'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SalaryRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete record?'),
        content: const Text(
          'This salary record will be permanently removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref.read(salaryListNotifierProvider.notifier).deleteRecord(record.id!);
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record deleted')),
      );
    }
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(value, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

final _salaryRecordProvider =
    FutureProvider.family<SalaryRecord?, int>((ref, id) {
  return ref.watch(getSalaryRecordByIdUseCaseProvider)(id);
});
