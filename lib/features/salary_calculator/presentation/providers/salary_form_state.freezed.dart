// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salary_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalaryFormState {

 String? get employeeName; String get basicSalaryText; String get numberOfDaysInMonthText; String get numberOfDaysServedText; String get pfPercentageText; String get eobiAmountText; String get taxAmountText;
/// Create a copy of SalaryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalaryFormStateCopyWith<SalaryFormState> get copyWith => _$SalaryFormStateCopyWithImpl<SalaryFormState>(this as SalaryFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalaryFormState&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.basicSalaryText, basicSalaryText) || other.basicSalaryText == basicSalaryText)&&(identical(other.numberOfDaysInMonthText, numberOfDaysInMonthText) || other.numberOfDaysInMonthText == numberOfDaysInMonthText)&&(identical(other.numberOfDaysServedText, numberOfDaysServedText) || other.numberOfDaysServedText == numberOfDaysServedText)&&(identical(other.pfPercentageText, pfPercentageText) || other.pfPercentageText == pfPercentageText)&&(identical(other.eobiAmountText, eobiAmountText) || other.eobiAmountText == eobiAmountText)&&(identical(other.taxAmountText, taxAmountText) || other.taxAmountText == taxAmountText));
}


@override
int get hashCode => Object.hash(runtimeType,employeeName,basicSalaryText,numberOfDaysInMonthText,numberOfDaysServedText,pfPercentageText,eobiAmountText,taxAmountText);

@override
String toString() {
  return 'SalaryFormState(employeeName: $employeeName, basicSalaryText: $basicSalaryText, numberOfDaysInMonthText: $numberOfDaysInMonthText, numberOfDaysServedText: $numberOfDaysServedText, pfPercentageText: $pfPercentageText, eobiAmountText: $eobiAmountText, taxAmountText: $taxAmountText)';
}


}

/// @nodoc
abstract mixin class $SalaryFormStateCopyWith<$Res>  {
  factory $SalaryFormStateCopyWith(SalaryFormState value, $Res Function(SalaryFormState) _then) = _$SalaryFormStateCopyWithImpl;
@useResult
$Res call({
 String? employeeName, String basicSalaryText, String numberOfDaysInMonthText, String numberOfDaysServedText, String pfPercentageText, String eobiAmountText, String taxAmountText
});




}
/// @nodoc
class _$SalaryFormStateCopyWithImpl<$Res>
    implements $SalaryFormStateCopyWith<$Res> {
  _$SalaryFormStateCopyWithImpl(this._self, this._then);

  final SalaryFormState _self;
  final $Res Function(SalaryFormState) _then;

/// Create a copy of SalaryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeName = freezed,Object? basicSalaryText = null,Object? numberOfDaysInMonthText = null,Object? numberOfDaysServedText = null,Object? pfPercentageText = null,Object? eobiAmountText = null,Object? taxAmountText = null,}) {
  return _then(_self.copyWith(
employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,basicSalaryText: null == basicSalaryText ? _self.basicSalaryText : basicSalaryText // ignore: cast_nullable_to_non_nullable
as String,numberOfDaysInMonthText: null == numberOfDaysInMonthText ? _self.numberOfDaysInMonthText : numberOfDaysInMonthText // ignore: cast_nullable_to_non_nullable
as String,numberOfDaysServedText: null == numberOfDaysServedText ? _self.numberOfDaysServedText : numberOfDaysServedText // ignore: cast_nullable_to_non_nullable
as String,pfPercentageText: null == pfPercentageText ? _self.pfPercentageText : pfPercentageText // ignore: cast_nullable_to_non_nullable
as String,eobiAmountText: null == eobiAmountText ? _self.eobiAmountText : eobiAmountText // ignore: cast_nullable_to_non_nullable
as String,taxAmountText: null == taxAmountText ? _self.taxAmountText : taxAmountText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SalaryFormState].
extension SalaryFormStatePatterns on SalaryFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalaryFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalaryFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalaryFormState value)  $default,){
final _that = this;
switch (_that) {
case _SalaryFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalaryFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SalaryFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? employeeName,  String basicSalaryText,  String numberOfDaysInMonthText,  String numberOfDaysServedText,  String pfPercentageText,  String eobiAmountText,  String taxAmountText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalaryFormState() when $default != null:
return $default(_that.employeeName,_that.basicSalaryText,_that.numberOfDaysInMonthText,_that.numberOfDaysServedText,_that.pfPercentageText,_that.eobiAmountText,_that.taxAmountText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? employeeName,  String basicSalaryText,  String numberOfDaysInMonthText,  String numberOfDaysServedText,  String pfPercentageText,  String eobiAmountText,  String taxAmountText)  $default,) {final _that = this;
switch (_that) {
case _SalaryFormState():
return $default(_that.employeeName,_that.basicSalaryText,_that.numberOfDaysInMonthText,_that.numberOfDaysServedText,_that.pfPercentageText,_that.eobiAmountText,_that.taxAmountText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? employeeName,  String basicSalaryText,  String numberOfDaysInMonthText,  String numberOfDaysServedText,  String pfPercentageText,  String eobiAmountText,  String taxAmountText)?  $default,) {final _that = this;
switch (_that) {
case _SalaryFormState() when $default != null:
return $default(_that.employeeName,_that.basicSalaryText,_that.numberOfDaysInMonthText,_that.numberOfDaysServedText,_that.pfPercentageText,_that.eobiAmountText,_that.taxAmountText);case _:
  return null;

}
}

}

/// @nodoc


class _SalaryFormState extends SalaryFormState {
  const _SalaryFormState({this.employeeName, this.basicSalaryText = '', this.numberOfDaysInMonthText = '30', this.numberOfDaysServedText = '', this.pfPercentageText = '7.5', this.eobiAmountText = '0', this.taxAmountText = '0'}): super._();
  

@override final  String? employeeName;
@override@JsonKey() final  String basicSalaryText;
@override@JsonKey() final  String numberOfDaysInMonthText;
@override@JsonKey() final  String numberOfDaysServedText;
@override@JsonKey() final  String pfPercentageText;
@override@JsonKey() final  String eobiAmountText;
@override@JsonKey() final  String taxAmountText;

/// Create a copy of SalaryFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalaryFormStateCopyWith<_SalaryFormState> get copyWith => __$SalaryFormStateCopyWithImpl<_SalaryFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalaryFormState&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.basicSalaryText, basicSalaryText) || other.basicSalaryText == basicSalaryText)&&(identical(other.numberOfDaysInMonthText, numberOfDaysInMonthText) || other.numberOfDaysInMonthText == numberOfDaysInMonthText)&&(identical(other.numberOfDaysServedText, numberOfDaysServedText) || other.numberOfDaysServedText == numberOfDaysServedText)&&(identical(other.pfPercentageText, pfPercentageText) || other.pfPercentageText == pfPercentageText)&&(identical(other.eobiAmountText, eobiAmountText) || other.eobiAmountText == eobiAmountText)&&(identical(other.taxAmountText, taxAmountText) || other.taxAmountText == taxAmountText));
}


@override
int get hashCode => Object.hash(runtimeType,employeeName,basicSalaryText,numberOfDaysInMonthText,numberOfDaysServedText,pfPercentageText,eobiAmountText,taxAmountText);

@override
String toString() {
  return 'SalaryFormState(employeeName: $employeeName, basicSalaryText: $basicSalaryText, numberOfDaysInMonthText: $numberOfDaysInMonthText, numberOfDaysServedText: $numberOfDaysServedText, pfPercentageText: $pfPercentageText, eobiAmountText: $eobiAmountText, taxAmountText: $taxAmountText)';
}


}

/// @nodoc
abstract mixin class _$SalaryFormStateCopyWith<$Res> implements $SalaryFormStateCopyWith<$Res> {
  factory _$SalaryFormStateCopyWith(_SalaryFormState value, $Res Function(_SalaryFormState) _then) = __$SalaryFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? employeeName, String basicSalaryText, String numberOfDaysInMonthText, String numberOfDaysServedText, String pfPercentageText, String eobiAmountText, String taxAmountText
});




}
/// @nodoc
class __$SalaryFormStateCopyWithImpl<$Res>
    implements _$SalaryFormStateCopyWith<$Res> {
  __$SalaryFormStateCopyWithImpl(this._self, this._then);

  final _SalaryFormState _self;
  final $Res Function(_SalaryFormState) _then;

/// Create a copy of SalaryFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeName = freezed,Object? basicSalaryText = null,Object? numberOfDaysInMonthText = null,Object? numberOfDaysServedText = null,Object? pfPercentageText = null,Object? eobiAmountText = null,Object? taxAmountText = null,}) {
  return _then(_SalaryFormState(
employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,basicSalaryText: null == basicSalaryText ? _self.basicSalaryText : basicSalaryText // ignore: cast_nullable_to_non_nullable
as String,numberOfDaysInMonthText: null == numberOfDaysInMonthText ? _self.numberOfDaysInMonthText : numberOfDaysInMonthText // ignore: cast_nullable_to_non_nullable
as String,numberOfDaysServedText: null == numberOfDaysServedText ? _self.numberOfDaysServedText : numberOfDaysServedText // ignore: cast_nullable_to_non_nullable
as String,pfPercentageText: null == pfPercentageText ? _self.pfPercentageText : pfPercentageText // ignore: cast_nullable_to_non_nullable
as String,eobiAmountText: null == eobiAmountText ? _self.eobiAmountText : eobiAmountText // ignore: cast_nullable_to_non_nullable
as String,taxAmountText: null == taxAmountText ? _self.taxAmountText : taxAmountText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
