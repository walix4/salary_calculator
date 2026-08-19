// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_calculation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salaryCalculationPreviewHash() =>
    r'43efe4d63fbb7776f1b0e3cc34da9cd09a4b7da3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Live salary calculation preview derived from form state.
///
/// Copied from [salaryCalculationPreview].
@ProviderFor(salaryCalculationPreview)
const salaryCalculationPreviewProvider = SalaryCalculationPreviewFamily();

/// Live salary calculation preview derived from form state.
///
/// Copied from [salaryCalculationPreview].
class SalaryCalculationPreviewFamily extends Family<SalaryBreakdown> {
  /// Live salary calculation preview derived from form state.
  ///
  /// Copied from [salaryCalculationPreview].
  const SalaryCalculationPreviewFamily();

  /// Live salary calculation preview derived from form state.
  ///
  /// Copied from [salaryCalculationPreview].
  SalaryCalculationPreviewProvider call({SalaryRecord? initialRecord}) {
    return SalaryCalculationPreviewProvider(initialRecord: initialRecord);
  }

  @override
  SalaryCalculationPreviewProvider getProviderOverride(
    covariant SalaryCalculationPreviewProvider provider,
  ) {
    return call(initialRecord: provider.initialRecord);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'salaryCalculationPreviewProvider';
}

/// Live salary calculation preview derived from form state.
///
/// Copied from [salaryCalculationPreview].
class SalaryCalculationPreviewProvider
    extends AutoDisposeProvider<SalaryBreakdown> {
  /// Live salary calculation preview derived from form state.
  ///
  /// Copied from [salaryCalculationPreview].
  SalaryCalculationPreviewProvider({SalaryRecord? initialRecord})
    : this._internal(
        (ref) => salaryCalculationPreview(
          ref as SalaryCalculationPreviewRef,
          initialRecord: initialRecord,
        ),
        from: salaryCalculationPreviewProvider,
        name: r'salaryCalculationPreviewProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salaryCalculationPreviewHash,
        dependencies: SalaryCalculationPreviewFamily._dependencies,
        allTransitiveDependencies:
            SalaryCalculationPreviewFamily._allTransitiveDependencies,
        initialRecord: initialRecord,
      );

  SalaryCalculationPreviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialRecord,
  }) : super.internal();

  final SalaryRecord? initialRecord;

  @override
  Override overrideWith(
    SalaryBreakdown Function(SalaryCalculationPreviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SalaryCalculationPreviewProvider._internal(
        (ref) => create(ref as SalaryCalculationPreviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialRecord: initialRecord,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<SalaryBreakdown> createElement() {
    return _SalaryCalculationPreviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalaryCalculationPreviewProvider &&
        other.initialRecord == initialRecord;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialRecord.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SalaryCalculationPreviewRef on AutoDisposeProviderRef<SalaryBreakdown> {
  /// The parameter `initialRecord` of this provider.
  SalaryRecord? get initialRecord;
}

class _SalaryCalculationPreviewProviderElement
    extends AutoDisposeProviderElement<SalaryBreakdown>
    with SalaryCalculationPreviewRef {
  _SalaryCalculationPreviewProviderElement(super.provider);

  @override
  SalaryRecord? get initialRecord =>
      (origin as SalaryCalculationPreviewProvider).initialRecord;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
