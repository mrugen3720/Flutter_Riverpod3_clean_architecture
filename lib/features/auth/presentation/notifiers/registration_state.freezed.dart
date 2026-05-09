// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationState {

 String get firstName; String get lastName; String get email; String get phone;/// Absolute file path of the selected profile image, or null.
 String? get profileImagePath; LoadStatus get loadStatus; String? get errorMessage; Map<String, String> get fieldErrors;
/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationStateCopyWith<RegistrationState> get copyWith => _$RegistrationStateCopyWithImpl<RegistrationState>(this as RegistrationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileImagePath, profileImagePath) || other.profileImagePath == profileImagePath)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.fieldErrors, fieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phone,profileImagePath,loadStatus,errorMessage,const DeepCollectionEquality().hash(fieldErrors));

@override
String toString() {
  return 'RegistrationState(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, profileImagePath: $profileImagePath, loadStatus: $loadStatus, errorMessage: $errorMessage, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class $RegistrationStateCopyWith<$Res>  {
  factory $RegistrationStateCopyWith(RegistrationState value, $Res Function(RegistrationState) _then) = _$RegistrationStateCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String phone, String? profileImagePath, LoadStatus loadStatus, String? errorMessage, Map<String, String> fieldErrors
});




}
/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._self, this._then);

  final RegistrationState _self;
  final $Res Function(RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? profileImagePath = freezed,Object? loadStatus = null,Object? errorMessage = freezed,Object? fieldErrors = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,profileImagePath: freezed == profileImagePath ? _self.profileImagePath : profileImagePath // ignore: cast_nullable_to_non_nullable
as String?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as LoadStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self.fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationState].
extension RegistrationStatePatterns on RegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationState value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationState value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phone,  String? profileImagePath,  LoadStatus loadStatus,  String? errorMessage,  Map<String, String> fieldErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.profileImagePath,_that.loadStatus,_that.errorMessage,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phone,  String? profileImagePath,  LoadStatus loadStatus,  String? errorMessage,  Map<String, String> fieldErrors)  $default,) {final _that = this;
switch (_that) {
case _RegistrationState():
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.profileImagePath,_that.loadStatus,_that.errorMessage,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String email,  String phone,  String? profileImagePath,  LoadStatus loadStatus,  String? errorMessage,  Map<String, String> fieldErrors)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.profileImagePath,_that.loadStatus,_that.errorMessage,_that.fieldErrors);case _:
  return null;

}
}

}

/// @nodoc


class _RegistrationState implements RegistrationState {
  const _RegistrationState({this.firstName = '', this.lastName = '', this.email = '', this.phone = '', this.profileImagePath, this.loadStatus = LoadStatus.initial, this.errorMessage, final  Map<String, String> fieldErrors = const <String, String>{}}): _fieldErrors = fieldErrors;
  

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
/// Absolute file path of the selected profile image, or null.
@override final  String? profileImagePath;
@override@JsonKey() final  LoadStatus loadStatus;
@override final  String? errorMessage;
 final  Map<String, String> _fieldErrors;
@override@JsonKey() Map<String, String> get fieldErrors {
  if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fieldErrors);
}


/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationStateCopyWith<_RegistrationState> get copyWith => __$RegistrationStateCopyWithImpl<_RegistrationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileImagePath, profileImagePath) || other.profileImagePath == profileImagePath)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._fieldErrors, _fieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phone,profileImagePath,loadStatus,errorMessage,const DeepCollectionEquality().hash(_fieldErrors));

@override
String toString() {
  return 'RegistrationState(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, profileImagePath: $profileImagePath, loadStatus: $loadStatus, errorMessage: $errorMessage, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class _$RegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory _$RegistrationStateCopyWith(_RegistrationState value, $Res Function(_RegistrationState) _then) = __$RegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String phone, String? profileImagePath, LoadStatus loadStatus, String? errorMessage, Map<String, String> fieldErrors
});




}
/// @nodoc
class __$RegistrationStateCopyWithImpl<$Res>
    implements _$RegistrationStateCopyWith<$Res> {
  __$RegistrationStateCopyWithImpl(this._self, this._then);

  final _RegistrationState _self;
  final $Res Function(_RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? profileImagePath = freezed,Object? loadStatus = null,Object? errorMessage = freezed,Object? fieldErrors = null,}) {
  return _then(_RegistrationState(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,profileImagePath: freezed == profileImagePath ? _self.profileImagePath : profileImagePath // ignore: cast_nullable_to_non_nullable
as String?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as LoadStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self._fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
