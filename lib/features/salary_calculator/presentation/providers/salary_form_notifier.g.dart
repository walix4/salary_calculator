// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salaryFormNotifierHash() =>
    r'f5668af0b8ddeb7ffd2d55a232d38b2928426cab';

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

abstract class _$SalaryFormNotifier
    extends BuildlessAutoDisposeNotifier<SalaryFormState> {
  late final SalaryRecord? initialRecord;

  SalaryFormState build({SalaryRecord? initialRecord});
}

/// Holds form field values for add/edit salary screens.
///
/// Copied from [SalaryFormNotifier].
@ProviderFor(SalaryFormNotifier)
const salaryFormNotifierProvider = SalaryFormNotifierFamily();

/// Holds form field values for add/edit salary screens.
///
/// Copied from [SalaryFormNotifier].
class SalaryFormNotifierFamily extends Family<SalaryFormState> {
  /// Holds form field values for add/edit salary screens.
  ///
  /// Copied from [SalaryFormNotifier].
  const SalaryFormNotifierFamily();

  /// Holds form field values for add/edit salary screens.
  ///
  /// Copied from [SalaryFormNotifier].
  SalaryFormNotifierProvider call({SalaryRecord? initialRecord}) {
    return SalaryFormNotifierProvider(initialRecord: initialRecord);
  }

  @override
  SalaryFormNotifierProvider getProviderOverride(
    covariant SalaryFormNotifierProvider provider,
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
  String? get name => r'salaryFormNotifierProvider';
}

/// Holds form field values for add/edit salary screens.
///
/// Copied from [SalaryFormNotifier].
class SalaryFormNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<SalaryFormNotifier, SalaryFormState> {
  /// Holds form field values for add/edit salary screens.
  ///
  /// Copied from [SalaryFormNotifier].
  SalaryFormNotifierProvider({SalaryRecord? initialRecord})
    : this._internal(
        () => SalaryFormNotifier()..initialRecord = initialRecord,
        from: salaryFormNotifierProvider,
        name: r'salaryFormNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salaryFormNotifierHash,
        dependencies: SalaryFormNotifierFamily._dependencies,
        allTransitiveDependencies:
            SalaryFormNotifierFamily._allTransitiveDependencies,
        initialRecord: initialRecord,
      );

  SalaryFormNotifierProvider._internal(
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
  SalaryFormState runNotifierBuild(covariant SalaryFormNotifier notifier) {
    return notifier.build(initialRecord: initialRecord);
  }

  @override
  Override overrideWith(SalaryFormNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SalaryFormNotifierProvider._internal(
        () => create()..initialRecord = initialRecord,
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
  AutoDisposeNotifierProviderElement<SalaryFormNotifier, SalaryFormState>
  createElement() {
    return _SalaryFormNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalaryFormNotifierProvider &&
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
mixin SalaryFormNotifierRef on AutoDisposeNotifierProviderRef<SalaryFormState> {
  /// The parameter `initialRecord` of this provider.
  SalaryRecord? get initialRecord;
}

class _SalaryFormNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<SalaryFormNotifier, SalaryFormState>
    with SalaryFormNotifierRef {
  _SalaryFormNotifierProviderElement(super.provider);

  @override
  SalaryRecord? get initialRecord =>
      (origin as SalaryFormNotifierProvider).initialRecord;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
