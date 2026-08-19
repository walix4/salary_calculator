// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salaryListNotifierHash() =>
    r'76c767348404a0030479cb13005b62ff1b3f7762';

/// Manages the salary records list via a reactive Drift stream.
///
/// Copied from [SalaryListNotifier].
@ProviderFor(SalaryListNotifier)
final salaryListNotifierProvider =
    AutoDisposeStreamNotifierProvider<
      SalaryListNotifier,
      List<SalaryRecord>
    >.internal(
      SalaryListNotifier.new,
      name: r'salaryListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$salaryListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SalaryListNotifier = AutoDisposeStreamNotifier<List<SalaryRecord>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
