// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salary_breakdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalaryBreakdown {

 double get basicSalary; double get proratedSalary; double get pfDeduction; double get eobiAmount; double get taxAmount; double get totalDeductions; double get netSalary;
/// Create a copy of SalaryBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalaryBreakdownCopyWith<SalaryBreakdown> get copyWith => _$SalaryBreakdownCopyWithImpl<SalaryBreakdown>(this as SalaryBreakdown, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalaryBreakdown&&(identical(other.basicSalary, basicSalary) || other.basicSalary == basicSalary)&&(identical(other.proratedSalary, proratedSalary) || other.proratedSalary == proratedSalary)&&(identical(other.pfDeduction, pfDeduction) || other.pfDeduction == pfDeduction)&&(identical(other.eobiAmount, eobiAmount) || other.eobiAmount == eobiAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalDeductions, totalDeductions) || other.totalDeductions == totalDeductions)&&(identical(other.netSalary, netSalary) || other.netSalary == netSalary));
}


@override
int get hashCode => Object.hash(runtimeType,basicSalary,proratedSalary,pfDeduction,eobiAmount,taxAmount,totalDeductions,netSalary);

@override
String toString() {
  return 'SalaryBreakdown(basicSalary: $basicSalary, proratedSalary: $proratedSalary, pfDeduction: $pfDeduction, eobiAmount: $eobiAmount, taxAmount: $taxAmount, totalDeductions: $totalDeductions, netSalary: $netSalary)';
}


}

/// @nodoc
abstract mixin class $SalaryBreakdownCopyWith<$Res>  {
  factory $SalaryBreakdownCopyWith(SalaryBreakdown value, $Res Function(SalaryBreakdown) _then) = _$SalaryBreakdownCopyWithImpl;
@useResult
$Res call({
 double basicSalary, double proratedSalary, double pfDeduction, double eobiAmount, double taxAmount, double totalDeductions, double netSalary
});




}
/// @nodoc
class _$SalaryBreakdownCopyWithImpl<$Res>
    implements $SalaryBreakdownCopyWith<$Res> {
  _$SalaryBreakdownCopyWithImpl(this._self, this._then);

  final SalaryBreakdown _self;
  final $Res Function(SalaryBreakdown) _then;

/// Create a copy of SalaryBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? basicSalary = null,Object? proratedSalary = null,Object? pfDeduction = null,Object? eobiAmount = null,Object? taxAmount = null,Object? totalDeductions = null,Object? netSalary = null,}) {
  return _then(_self.copyWith(
basicSalary: null == basicSalary ? _self.basicSalary : basicSalary // ignore: cast_nullable_to_non_nullable
as double,proratedSalary: null == proratedSalary ? _self.proratedSalary : proratedSalary // ignore: cast_nullable_to_non_nullable
as double,pfDeduction: null == pfDeduction ? _self.pfDeduction : pfDeduction // ignore: cast_nullable_to_non_nullable
as double,eobiAmount: null == eobiAmount ? _self.eobiAmount : eobiAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,totalDeductions: null == totalDeductions ? _self.totalDeductions : totalDeductions // ignore: cast_nullable_to_non_nullable
as double,netSalary: null == netSalary ? _self.netSalary : netSalary // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SalaryBreakdown].
extension SalaryBreakdownPatterns on SalaryBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalaryBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalaryBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalaryBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _SalaryBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalaryBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _SalaryBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double basicSalary,  double proratedSalary,  double pfDeduction,  double eobiAmount,  double taxAmount,  double totalDeductions,  double netSalary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalaryBreakdown() when $default != null:
return $default(_that.basicSalary,_that.proratedSalary,_that.pfDeduction,_that.eobiAmount,_that.taxAmount,_that.totalDeductions,_that.netSalary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double basicSalary,  double proratedSalary,  double pfDeduction,  double eobiAmount,  double taxAmount,  double totalDeductions,  double netSalary)  $default,) {final _that = this;
switch (_that) {
case _SalaryBreakdown():
return $default(_that.basicSalary,_that.proratedSalary,_that.pfDeduction,_that.eobiAmount,_that.taxAmount,_that.totalDeductions,_that.netSalary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double basicSalary,  double proratedSalary,  double pfDeduction,  double eobiAmount,  double taxAmount,  double totalDeductions,  double netSalary)?  $default,) {final _that = this;
switch (_that) {
case _SalaryBreakdown() when $default != null:
return $default(_that.basicSalary,_that.proratedSalary,_that.pfDeduction,_that.eobiAmount,_that.taxAmount,_that.totalDeductions,_that.netSalary);case _:
  return null;

}
}

}

/// @nodoc


class _SalaryBreakdown implements SalaryBreakdown {
  const _SalaryBreakdown({required this.basicSalary, required this.proratedSalary, required this.pfDeduction, required this.eobiAmount, required this.taxAmount, required this.totalDeductions, required this.netSalary});
  

@override final  double basicSalary;
@override final  double proratedSalary;
@override final  double pfDeduction;
@override final  double eobiAmount;
@override final  double taxAmount;
@override final  double totalDeductions;
@override final  double netSalary;

/// Create a copy of SalaryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalaryBreakdownCopyWith<_SalaryBreakdown> get copyWith => __$SalaryBreakdownCopyWithImpl<_SalaryBreakdown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalaryBreakdown&&(identical(other.basicSalary, basicSalary) || other.basicSalary == basicSalary)&&(identical(other.proratedSalary, proratedSalary) || other.proratedSalary == proratedSalary)&&(identical(other.pfDeduction, pfDeduction) || other.pfDeduction == pfDeduction)&&(identical(other.eobiAmount, eobiAmount) || other.eobiAmount == eobiAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalDeductions, totalDeductions) || other.totalDeductions == totalDeductions)&&(identical(other.netSalary, netSalary) || other.netSalary == netSalary));
}


@override
int get hashCode => Object.hash(runtimeType,basicSalary,proratedSalary,pfDeduction,eobiAmount,taxAmount,totalDeductions,netSalary);

@override
String toString() {
  return 'SalaryBreakdown(basicSalary: $basicSalary, proratedSalary: $proratedSalary, pfDeduction: $pfDeduction, eobiAmount: $eobiAmount, taxAmount: $taxAmount, totalDeductions: $totalDeductions, netSalary: $netSalary)';
}


}

/// @nodoc
abstract mixin class _$SalaryBreakdownCopyWith<$Res> implements $SalaryBreakdownCopyWith<$Res> {
  factory _$SalaryBreakdownCopyWith(_SalaryBreakdown value, $Res Function(_SalaryBreakdown) _then) = __$SalaryBreakdownCopyWithImpl;
@override @useResult
$Res call({
 double basicSalary, double proratedSalary, double pfDeduction, double eobiAmount, double taxAmount, double totalDeductions, double netSalary
});




}
/// @nodoc
class __$SalaryBreakdownCopyWithImpl<$Res>
    implements _$SalaryBreakdownCopyWith<$Res> {
  __$SalaryBreakdownCopyWithImpl(this._self, this._then);

  final _SalaryBreakdown _self;
  final $Res Function(_SalaryBreakdown) _then;

/// Create a copy of SalaryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? basicSalary = null,Object? proratedSalary = null,Object? pfDeduction = null,Object? eobiAmount = null,Object? taxAmount = null,Object? totalDeductions = null,Object? netSalary = null,}) {
  return _then(_SalaryBreakdown(
basicSalary: null == basicSalary ? _self.basicSalary : basicSalary // ignore: cast_nullable_to_non_nullable
as double,proratedSalary: null == proratedSalary ? _self.proratedSalary : proratedSalary // ignore: cast_nullable_to_non_nullable
as double,pfDeduction: null == pfDeduction ? _self.pfDeduction : pfDeduction // ignore: cast_nullable_to_non_nullable
as double,eobiAmount: null == eobiAmount ? _self.eobiAmount : eobiAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,totalDeductions: null == totalDeductions ? _self.totalDeductions : totalDeductions // ignore: cast_nullable_to_non_nullable
as double,netSalary: null == netSalary ? _self.netSalary : netSalary // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
