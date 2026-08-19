// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salary_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalaryRecord {

 int? get id; String? get employeeName; double get basicSalary; int get numberOfDaysInMonth; int get numberOfDaysServed; double get pfPercentage; double get eobiAmount; double get taxAmount; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of SalaryRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalaryRecordCopyWith<SalaryRecord> get copyWith => _$SalaryRecordCopyWithImpl<SalaryRecord>(this as SalaryRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalaryRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.basicSalary, basicSalary) || other.basicSalary == basicSalary)&&(identical(other.numberOfDaysInMonth, numberOfDaysInMonth) || other.numberOfDaysInMonth == numberOfDaysInMonth)&&(identical(other.numberOfDaysServed, numberOfDaysServed) || other.numberOfDaysServed == numberOfDaysServed)&&(identical(other.pfPercentage, pfPercentage) || other.pfPercentage == pfPercentage)&&(identical(other.eobiAmount, eobiAmount) || other.eobiAmount == eobiAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeName,basicSalary,numberOfDaysInMonth,numberOfDaysServed,pfPercentage,eobiAmount,taxAmount,createdAt,updatedAt);

@override
String toString() {
  return 'SalaryRecord(id: $id, employeeName: $employeeName, basicSalary: $basicSalary, numberOfDaysInMonth: $numberOfDaysInMonth, numberOfDaysServed: $numberOfDaysServed, pfPercentage: $pfPercentage, eobiAmount: $eobiAmount, taxAmount: $taxAmount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SalaryRecordCopyWith<$Res>  {
  factory $SalaryRecordCopyWith(SalaryRecord value, $Res Function(SalaryRecord) _then) = _$SalaryRecordCopyWithImpl;
@useResult
$Res call({
 int? id, String? employeeName, double basicSalary, int numberOfDaysInMonth, int numberOfDaysServed, double pfPercentage, double eobiAmount, double taxAmount, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SalaryRecordCopyWithImpl<$Res>
    implements $SalaryRecordCopyWith<$Res> {
  _$SalaryRecordCopyWithImpl(this._self, this._then);

  final SalaryRecord _self;
  final $Res Function(SalaryRecord) _then;

/// Create a copy of SalaryRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? employeeName = freezed,Object? basicSalary = null,Object? numberOfDaysInMonth = null,Object? numberOfDaysServed = null,Object? pfPercentage = null,Object? eobiAmount = null,Object? taxAmount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,basicSalary: null == basicSalary ? _self.basicSalary : basicSalary // ignore: cast_nullable_to_non_nullable
as double,numberOfDaysInMonth: null == numberOfDaysInMonth ? _self.numberOfDaysInMonth : numberOfDaysInMonth // ignore: cast_nullable_to_non_nullable
as int,numberOfDaysServed: null == numberOfDaysServed ? _self.numberOfDaysServed : numberOfDaysServed // ignore: cast_nullable_to_non_nullable
as int,pfPercentage: null == pfPercentage ? _self.pfPercentage : pfPercentage // ignore: cast_nullable_to_non_nullable
as double,eobiAmount: null == eobiAmount ? _self.eobiAmount : eobiAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SalaryRecord].
extension SalaryRecordPatterns on SalaryRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalaryRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalaryRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalaryRecord value)  $default,){
final _that = this;
switch (_that) {
case _SalaryRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalaryRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SalaryRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? employeeName,  double basicSalary,  int numberOfDaysInMonth,  int numberOfDaysServed,  double pfPercentage,  double eobiAmount,  double taxAmount,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalaryRecord() when $default != null:
return $default(_that.id,_that.employeeName,_that.basicSalary,_that.numberOfDaysInMonth,_that.numberOfDaysServed,_that.pfPercentage,_that.eobiAmount,_that.taxAmount,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? employeeName,  double basicSalary,  int numberOfDaysInMonth,  int numberOfDaysServed,  double pfPercentage,  double eobiAmount,  double taxAmount,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SalaryRecord():
return $default(_that.id,_that.employeeName,_that.basicSalary,_that.numberOfDaysInMonth,_that.numberOfDaysServed,_that.pfPercentage,_that.eobiAmount,_that.taxAmount,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? employeeName,  double basicSalary,  int numberOfDaysInMonth,  int numberOfDaysServed,  double pfPercentage,  double eobiAmount,  double taxAmount,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SalaryRecord() when $default != null:
return $default(_that.id,_that.employeeName,_that.basicSalary,_that.numberOfDaysInMonth,_that.numberOfDaysServed,_that.pfPercentage,_that.eobiAmount,_that.taxAmount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SalaryRecord implements SalaryRecord {
  const _SalaryRecord({this.id, this.employeeName, required this.basicSalary, required this.numberOfDaysInMonth, required this.numberOfDaysServed, this.pfPercentage = AppConstants.defaultPfPercentage, required this.eobiAmount, required this.taxAmount, required this.createdAt, required this.updatedAt});
  

@override final  int? id;
@override final  String? employeeName;
@override final  double basicSalary;
@override final  int numberOfDaysInMonth;
@override final  int numberOfDaysServed;
@override@JsonKey() final  double pfPercentage;
@override final  double eobiAmount;
@override final  double taxAmount;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of SalaryRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalaryRecordCopyWith<_SalaryRecord> get copyWith => __$SalaryRecordCopyWithImpl<_SalaryRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalaryRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.basicSalary, basicSalary) || other.basicSalary == basicSalary)&&(identical(other.numberOfDaysInMonth, numberOfDaysInMonth) || other.numberOfDaysInMonth == numberOfDaysInMonth)&&(identical(other.numberOfDaysServed, numberOfDaysServed) || other.numberOfDaysServed == numberOfDaysServed)&&(identical(other.pfPercentage, pfPercentage) || other.pfPercentage == pfPercentage)&&(identical(other.eobiAmount, eobiAmount) || other.eobiAmount == eobiAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeName,basicSalary,numberOfDaysInMonth,numberOfDaysServed,pfPercentage,eobiAmount,taxAmount,createdAt,updatedAt);

@override
String toString() {
  return 'SalaryRecord(id: $id, employeeName: $employeeName, basicSalary: $basicSalary, numberOfDaysInMonth: $numberOfDaysInMonth, numberOfDaysServed: $numberOfDaysServed, pfPercentage: $pfPercentage, eobiAmount: $eobiAmount, taxAmount: $taxAmount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SalaryRecordCopyWith<$Res> implements $SalaryRecordCopyWith<$Res> {
  factory _$SalaryRecordCopyWith(_SalaryRecord value, $Res Function(_SalaryRecord) _then) = __$SalaryRecordCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? employeeName, double basicSalary, int numberOfDaysInMonth, int numberOfDaysServed, double pfPercentage, double eobiAmount, double taxAmount, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SalaryRecordCopyWithImpl<$Res>
    implements _$SalaryRecordCopyWith<$Res> {
  __$SalaryRecordCopyWithImpl(this._self, this._then);

  final _SalaryRecord _self;
  final $Res Function(_SalaryRecord) _then;

/// Create a copy of SalaryRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? employeeName = freezed,Object? basicSalary = null,Object? numberOfDaysInMonth = null,Object? numberOfDaysServed = null,Object? pfPercentage = null,Object? eobiAmount = null,Object? taxAmount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SalaryRecord(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,basicSalary: null == basicSalary ? _self.basicSalary : basicSalary // ignore: cast_nullable_to_non_nullable
as double,numberOfDaysInMonth: null == numberOfDaysInMonth ? _self.numberOfDaysInMonth : numberOfDaysInMonth // ignore: cast_nullable_to_non_nullable
as int,numberOfDaysServed: null == numberOfDaysServed ? _self.numberOfDaysServed : numberOfDaysServed // ignore: cast_nullable_to_non_nullable
as int,pfPercentage: null == pfPercentage ? _self.pfPercentage : pfPercentage // ignore: cast_nullable_to_non_nullable
as double,eobiAmount: null == eobiAmount ? _self.eobiAmount : eobiAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
