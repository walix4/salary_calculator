// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SalaryRecordsTable extends SalaryRecords
    with TableInfo<$SalaryRecordsTable, SalaryRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalaryRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _employeeNameMeta = const VerificationMeta(
    'employeeName',
  );
  @override
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
    'employee_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basicSalaryMeta = const VerificationMeta(
    'basicSalary',
  );
  @override
  late final GeneratedColumn<double> basicSalary = GeneratedColumn<double>(
    'basic_salary',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfDaysInMonthMeta =
      const VerificationMeta('numberOfDaysInMonth');
  @override
  late final GeneratedColumn<int> numberOfDaysInMonth = GeneratedColumn<int>(
    'number_of_days_in_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfDaysServedMeta =
      const VerificationMeta('numberOfDaysServed');
  @override
  late final GeneratedColumn<int> numberOfDaysServed = GeneratedColumn<int>(
    'number_of_days_served',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pfPercentageMeta = const VerificationMeta(
    'pfPercentage',
  );
  @override
  late final GeneratedColumn<double> pfPercentage = GeneratedColumn<double>(
    'pf_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(7.5),
  );
  static const VerificationMeta _eobiAmountMeta = const VerificationMeta(
    'eobiAmount',
  );
  @override
  late final GeneratedColumn<double> eobiAmount = GeneratedColumn<double>(
    'eobi_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeName,
    basicSalary,
    numberOfDaysInMonth,
    numberOfDaysServed,
    pfPercentage,
    eobiAmount,
    taxAmount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalaryRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_name')) {
      context.handle(
        _employeeNameMeta,
        employeeName.isAcceptableOrUnknown(
          data['employee_name']!,
          _employeeNameMeta,
        ),
      );
    }
    if (data.containsKey('basic_salary')) {
      context.handle(
        _basicSalaryMeta,
        basicSalary.isAcceptableOrUnknown(
          data['basic_salary']!,
          _basicSalaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_basicSalaryMeta);
    }
    if (data.containsKey('number_of_days_in_month')) {
      context.handle(
        _numberOfDaysInMonthMeta,
        numberOfDaysInMonth.isAcceptableOrUnknown(
          data['number_of_days_in_month']!,
          _numberOfDaysInMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfDaysInMonthMeta);
    }
    if (data.containsKey('number_of_days_served')) {
      context.handle(
        _numberOfDaysServedMeta,
        numberOfDaysServed.isAcceptableOrUnknown(
          data['number_of_days_served']!,
          _numberOfDaysServedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfDaysServedMeta);
    }
    if (data.containsKey('pf_percentage')) {
      context.handle(
        _pfPercentageMeta,
        pfPercentage.isAcceptableOrUnknown(
          data['pf_percentage']!,
          _pfPercentageMeta,
        ),
      );
    }
    if (data.containsKey('eobi_amount')) {
      context.handle(
        _eobiAmountMeta,
        eobiAmount.isAcceptableOrUnknown(data['eobi_amount']!, _eobiAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_eobiAmountMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_taxAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalaryRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalaryRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_name'],
      ),
      basicSalary: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}basic_salary'],
      )!,
      numberOfDaysInMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_days_in_month'],
      )!,
      numberOfDaysServed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_days_served'],
      )!,
      pfPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pf_percentage'],
      )!,
      eobiAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}eobi_amount'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SalaryRecordsTable createAlias(String alias) {
    return $SalaryRecordsTable(attachedDatabase, alias);
  }
}

class SalaryRecordRow extends DataClass implements Insertable<SalaryRecordRow> {
  final int id;
  final String? employeeName;
  final double basicSalary;
  final int numberOfDaysInMonth;
  final int numberOfDaysServed;
  final double pfPercentage;
  final double eobiAmount;
  final double taxAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SalaryRecordRow({
    required this.id,
    this.employeeName,
    required this.basicSalary,
    required this.numberOfDaysInMonth,
    required this.numberOfDaysServed,
    required this.pfPercentage,
    required this.eobiAmount,
    required this.taxAmount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || employeeName != null) {
      map['employee_name'] = Variable<String>(employeeName);
    }
    map['basic_salary'] = Variable<double>(basicSalary);
    map['number_of_days_in_month'] = Variable<int>(numberOfDaysInMonth);
    map['number_of_days_served'] = Variable<int>(numberOfDaysServed);
    map['pf_percentage'] = Variable<double>(pfPercentage);
    map['eobi_amount'] = Variable<double>(eobiAmount);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SalaryRecordsCompanion toCompanion(bool nullToAbsent) {
    return SalaryRecordsCompanion(
      id: Value(id),
      employeeName: employeeName == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeName),
      basicSalary: Value(basicSalary),
      numberOfDaysInMonth: Value(numberOfDaysInMonth),
      numberOfDaysServed: Value(numberOfDaysServed),
      pfPercentage: Value(pfPercentage),
      eobiAmount: Value(eobiAmount),
      taxAmount: Value(taxAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SalaryRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalaryRecordRow(
      id: serializer.fromJson<int>(json['id']),
      employeeName: serializer.fromJson<String?>(json['employeeName']),
      basicSalary: serializer.fromJson<double>(json['basicSalary']),
      numberOfDaysInMonth: serializer.fromJson<int>(
        json['numberOfDaysInMonth'],
      ),
      numberOfDaysServed: serializer.fromJson<int>(json['numberOfDaysServed']),
      pfPercentage: serializer.fromJson<double>(json['pfPercentage']),
      eobiAmount: serializer.fromJson<double>(json['eobiAmount']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeName': serializer.toJson<String?>(employeeName),
      'basicSalary': serializer.toJson<double>(basicSalary),
      'numberOfDaysInMonth': serializer.toJson<int>(numberOfDaysInMonth),
      'numberOfDaysServed': serializer.toJson<int>(numberOfDaysServed),
      'pfPercentage': serializer.toJson<double>(pfPercentage),
      'eobiAmount': serializer.toJson<double>(eobiAmount),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SalaryRecordRow copyWith({
    int? id,
    Value<String?> employeeName = const Value.absent(),
    double? basicSalary,
    int? numberOfDaysInMonth,
    int? numberOfDaysServed,
    double? pfPercentage,
    double? eobiAmount,
    double? taxAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SalaryRecordRow(
    id: id ?? this.id,
    employeeName: employeeName.present ? employeeName.value : this.employeeName,
    basicSalary: basicSalary ?? this.basicSalary,
    numberOfDaysInMonth: numberOfDaysInMonth ?? this.numberOfDaysInMonth,
    numberOfDaysServed: numberOfDaysServed ?? this.numberOfDaysServed,
    pfPercentage: pfPercentage ?? this.pfPercentage,
    eobiAmount: eobiAmount ?? this.eobiAmount,
    taxAmount: taxAmount ?? this.taxAmount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SalaryRecordRow copyWithCompanion(SalaryRecordsCompanion data) {
    return SalaryRecordRow(
      id: data.id.present ? data.id.value : this.id,
      employeeName: data.employeeName.present
          ? data.employeeName.value
          : this.employeeName,
      basicSalary: data.basicSalary.present
          ? data.basicSalary.value
          : this.basicSalary,
      numberOfDaysInMonth: data.numberOfDaysInMonth.present
          ? data.numberOfDaysInMonth.value
          : this.numberOfDaysInMonth,
      numberOfDaysServed: data.numberOfDaysServed.present
          ? data.numberOfDaysServed.value
          : this.numberOfDaysServed,
      pfPercentage: data.pfPercentage.present
          ? data.pfPercentage.value
          : this.pfPercentage,
      eobiAmount: data.eobiAmount.present
          ? data.eobiAmount.value
          : this.eobiAmount,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalaryRecordRow(')
          ..write('id: $id, ')
          ..write('employeeName: $employeeName, ')
          ..write('basicSalary: $basicSalary, ')
          ..write('numberOfDaysInMonth: $numberOfDaysInMonth, ')
          ..write('numberOfDaysServed: $numberOfDaysServed, ')
          ..write('pfPercentage: $pfPercentage, ')
          ..write('eobiAmount: $eobiAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeName,
    basicSalary,
    numberOfDaysInMonth,
    numberOfDaysServed,
    pfPercentage,
    eobiAmount,
    taxAmount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalaryRecordRow &&
          other.id == this.id &&
          other.employeeName == this.employeeName &&
          other.basicSalary == this.basicSalary &&
          other.numberOfDaysInMonth == this.numberOfDaysInMonth &&
          other.numberOfDaysServed == this.numberOfDaysServed &&
          other.pfPercentage == this.pfPercentage &&
          other.eobiAmount == this.eobiAmount &&
          other.taxAmount == this.taxAmount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalaryRecordsCompanion extends UpdateCompanion<SalaryRecordRow> {
  final Value<int> id;
  final Value<String?> employeeName;
  final Value<double> basicSalary;
  final Value<int> numberOfDaysInMonth;
  final Value<int> numberOfDaysServed;
  final Value<double> pfPercentage;
  final Value<double> eobiAmount;
  final Value<double> taxAmount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SalaryRecordsCompanion({
    this.id = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.basicSalary = const Value.absent(),
    this.numberOfDaysInMonth = const Value.absent(),
    this.numberOfDaysServed = const Value.absent(),
    this.pfPercentage = const Value.absent(),
    this.eobiAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SalaryRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.employeeName = const Value.absent(),
    required double basicSalary,
    required int numberOfDaysInMonth,
    required int numberOfDaysServed,
    this.pfPercentage = const Value.absent(),
    required double eobiAmount,
    required double taxAmount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : basicSalary = Value(basicSalary),
       numberOfDaysInMonth = Value(numberOfDaysInMonth),
       numberOfDaysServed = Value(numberOfDaysServed),
       eobiAmount = Value(eobiAmount),
       taxAmount = Value(taxAmount),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SalaryRecordRow> custom({
    Expression<int>? id,
    Expression<String>? employeeName,
    Expression<double>? basicSalary,
    Expression<int>? numberOfDaysInMonth,
    Expression<int>? numberOfDaysServed,
    Expression<double>? pfPercentage,
    Expression<double>? eobiAmount,
    Expression<double>? taxAmount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeName != null) 'employee_name': employeeName,
      if (basicSalary != null) 'basic_salary': basicSalary,
      if (numberOfDaysInMonth != null)
        'number_of_days_in_month': numberOfDaysInMonth,
      if (numberOfDaysServed != null)
        'number_of_days_served': numberOfDaysServed,
      if (pfPercentage != null) 'pf_percentage': pfPercentage,
      if (eobiAmount != null) 'eobi_amount': eobiAmount,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SalaryRecordsCompanion copyWith({
    Value<int>? id,
    Value<String?>? employeeName,
    Value<double>? basicSalary,
    Value<int>? numberOfDaysInMonth,
    Value<int>? numberOfDaysServed,
    Value<double>? pfPercentage,
    Value<double>? eobiAmount,
    Value<double>? taxAmount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SalaryRecordsCompanion(
      id: id ?? this.id,
      employeeName: employeeName ?? this.employeeName,
      basicSalary: basicSalary ?? this.basicSalary,
      numberOfDaysInMonth: numberOfDaysInMonth ?? this.numberOfDaysInMonth,
      numberOfDaysServed: numberOfDaysServed ?? this.numberOfDaysServed,
      pfPercentage: pfPercentage ?? this.pfPercentage,
      eobiAmount: eobiAmount ?? this.eobiAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    if (basicSalary.present) {
      map['basic_salary'] = Variable<double>(basicSalary.value);
    }
    if (numberOfDaysInMonth.present) {
      map['number_of_days_in_month'] = Variable<int>(numberOfDaysInMonth.value);
    }
    if (numberOfDaysServed.present) {
      map['number_of_days_served'] = Variable<int>(numberOfDaysServed.value);
    }
    if (pfPercentage.present) {
      map['pf_percentage'] = Variable<double>(pfPercentage.value);
    }
    if (eobiAmount.present) {
      map['eobi_amount'] = Variable<double>(eobiAmount.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalaryRecordsCompanion(')
          ..write('id: $id, ')
          ..write('employeeName: $employeeName, ')
          ..write('basicSalary: $basicSalary, ')
          ..write('numberOfDaysInMonth: $numberOfDaysInMonth, ')
          ..write('numberOfDaysServed: $numberOfDaysServed, ')
          ..write('pfPercentage: $pfPercentage, ')
          ..write('eobiAmount: $eobiAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SalaryRecordsTable salaryRecords = $SalaryRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [salaryRecords];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SalaryRecordsTableCreateCompanionBuilder =
    SalaryRecordsCompanion Function({
      Value<int> id,
      Value<String?> employeeName,
      required double basicSalary,
      required int numberOfDaysInMonth,
      required int numberOfDaysServed,
      Value<double> pfPercentage,
      required double eobiAmount,
      required double taxAmount,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$SalaryRecordsTableUpdateCompanionBuilder =
    SalaryRecordsCompanion Function({
      Value<int> id,
      Value<String?> employeeName,
      Value<double> basicSalary,
      Value<int> numberOfDaysInMonth,
      Value<int> numberOfDaysServed,
      Value<double> pfPercentage,
      Value<double> eobiAmount,
      Value<double> taxAmount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SalaryRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SalaryRecordsTable> {
  $$SalaryRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeName => $composableBuilder(
    column: $table.employeeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basicSalary => $composableBuilder(
    column: $table.basicSalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfDaysInMonth => $composableBuilder(
    column: $table.numberOfDaysInMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfDaysServed => $composableBuilder(
    column: $table.numberOfDaysServed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pfPercentage => $composableBuilder(
    column: $table.pfPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get eobiAmount => $composableBuilder(
    column: $table.eobiAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalaryRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalaryRecordsTable> {
  $$SalaryRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeName => $composableBuilder(
    column: $table.employeeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basicSalary => $composableBuilder(
    column: $table.basicSalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfDaysInMonth => $composableBuilder(
    column: $table.numberOfDaysInMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfDaysServed => $composableBuilder(
    column: $table.numberOfDaysServed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pfPercentage => $composableBuilder(
    column: $table.pfPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get eobiAmount => $composableBuilder(
    column: $table.eobiAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalaryRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalaryRecordsTable> {
  $$SalaryRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get employeeName => $composableBuilder(
    column: $table.employeeName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get basicSalary => $composableBuilder(
    column: $table.basicSalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfDaysInMonth => $composableBuilder(
    column: $table.numberOfDaysInMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfDaysServed => $composableBuilder(
    column: $table.numberOfDaysServed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pfPercentage => $composableBuilder(
    column: $table.pfPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get eobiAmount => $composableBuilder(
    column: $table.eobiAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SalaryRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalaryRecordsTable,
          SalaryRecordRow,
          $$SalaryRecordsTableFilterComposer,
          $$SalaryRecordsTableOrderingComposer,
          $$SalaryRecordsTableAnnotationComposer,
          $$SalaryRecordsTableCreateCompanionBuilder,
          $$SalaryRecordsTableUpdateCompanionBuilder,
          (
            SalaryRecordRow,
            BaseReferences<_$AppDatabase, $SalaryRecordsTable, SalaryRecordRow>,
          ),
          SalaryRecordRow,
          PrefetchHooks Function()
        > {
  $$SalaryRecordsTableTableManager(_$AppDatabase db, $SalaryRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalaryRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalaryRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalaryRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> employeeName = const Value.absent(),
                Value<double> basicSalary = const Value.absent(),
                Value<int> numberOfDaysInMonth = const Value.absent(),
                Value<int> numberOfDaysServed = const Value.absent(),
                Value<double> pfPercentage = const Value.absent(),
                Value<double> eobiAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SalaryRecordsCompanion(
                id: id,
                employeeName: employeeName,
                basicSalary: basicSalary,
                numberOfDaysInMonth: numberOfDaysInMonth,
                numberOfDaysServed: numberOfDaysServed,
                pfPercentage: pfPercentage,
                eobiAmount: eobiAmount,
                taxAmount: taxAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> employeeName = const Value.absent(),
                required double basicSalary,
                required int numberOfDaysInMonth,
                required int numberOfDaysServed,
                Value<double> pfPercentage = const Value.absent(),
                required double eobiAmount,
                required double taxAmount,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => SalaryRecordsCompanion.insert(
                id: id,
                employeeName: employeeName,
                basicSalary: basicSalary,
                numberOfDaysInMonth: numberOfDaysInMonth,
                numberOfDaysServed: numberOfDaysServed,
                pfPercentage: pfPercentage,
                eobiAmount: eobiAmount,
                taxAmount: taxAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalaryRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalaryRecordsTable,
      SalaryRecordRow,
      $$SalaryRecordsTableFilterComposer,
      $$SalaryRecordsTableOrderingComposer,
      $$SalaryRecordsTableAnnotationComposer,
      $$SalaryRecordsTableCreateCompanionBuilder,
      $$SalaryRecordsTableUpdateCompanionBuilder,
      (
        SalaryRecordRow,
        BaseReferences<_$AppDatabase, $SalaryRecordsTable, SalaryRecordRow>,
      ),
      SalaryRecordRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SalaryRecordsTableTableManager get salaryRecords =>
      $$SalaryRecordsTableTableManager(_db, _db.salaryRecords);
}
