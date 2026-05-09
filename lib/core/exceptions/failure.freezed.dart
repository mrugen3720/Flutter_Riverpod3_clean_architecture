// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( CancelledFailure value)?  cancelled,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( ForbiddenFailure value)?  forbidden,TResult Function( NotFoundFailure value)?  notFound,TResult Function( ValidationFailure value)?  validation,TResult Function( ServerFailure value)?  server,TResult Function( ForceUpdateFailure value)?  forceUpdate,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ForbiddenFailure() when forbidden != null:
return forbidden(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case ValidationFailure() when validation != null:
return validation(_that);case ServerFailure() when server != null:
return server(_that);case ForceUpdateFailure() when forceUpdate != null:
return forceUpdate(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( CancelledFailure value)  cancelled,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( ForbiddenFailure value)  forbidden,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( ValidationFailure value)  validation,required TResult Function( ServerFailure value)  server,required TResult Function( ForceUpdateFailure value)  forceUpdate,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case CancelledFailure():
return cancelled(_that);case UnauthorizedFailure():
return unauthorized(_that);case ForbiddenFailure():
return forbidden(_that);case NotFoundFailure():
return notFound(_that);case ValidationFailure():
return validation(_that);case ServerFailure():
return server(_that);case ForceUpdateFailure():
return forceUpdate(_that);case UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( CancelledFailure value)?  cancelled,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( ForbiddenFailure value)?  forbidden,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( ValidationFailure value)?  validation,TResult? Function( ServerFailure value)?  server,TResult? Function( ForceUpdateFailure value)?  forceUpdate,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ForbiddenFailure() when forbidden != null:
return forbidden(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case ValidationFailure() when validation != null:
return validation(_that);case ServerFailure() when server != null:
return server(_that);case ForceUpdateFailure() when forceUpdate != null:
return forceUpdate(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  network,TResult Function()?  timeout,TResult Function()?  cancelled,TResult Function( String? message)?  unauthorized,TResult Function( String? message)?  forbidden,TResult Function( String? message)?  notFound,TResult Function( Map<String, List<String>> errors,  String? message)?  validation,TResult Function( int? code,  String? message)?  server,TResult Function( String message)?  forceUpdate,TResult Function( String message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case CancelledFailure() when cancelled != null:
return cancelled();case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.message);case ForbiddenFailure() when forbidden != null:
return forbidden(_that.message);case NotFoundFailure() when notFound != null:
return notFound(_that.message);case ValidationFailure() when validation != null:
return validation(_that.errors,_that.message);case ServerFailure() when server != null:
return server(_that.code,_that.message);case ForceUpdateFailure() when forceUpdate != null:
return forceUpdate(_that.message);case UnknownFailure() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  network,required TResult Function()  timeout,required TResult Function()  cancelled,required TResult Function( String? message)  unauthorized,required TResult Function( String? message)  forbidden,required TResult Function( String? message)  notFound,required TResult Function( Map<String, List<String>> errors,  String? message)  validation,required TResult Function( int? code,  String? message)  server,required TResult Function( String message)  forceUpdate,required TResult Function( String message)  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network();case TimeoutFailure():
return timeout();case CancelledFailure():
return cancelled();case UnauthorizedFailure():
return unauthorized(_that.message);case ForbiddenFailure():
return forbidden(_that.message);case NotFoundFailure():
return notFound(_that.message);case ValidationFailure():
return validation(_that.errors,_that.message);case ServerFailure():
return server(_that.code,_that.message);case ForceUpdateFailure():
return forceUpdate(_that.message);case UnknownFailure():
return unknown(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  network,TResult? Function()?  timeout,TResult? Function()?  cancelled,TResult? Function( String? message)?  unauthorized,TResult? Function( String? message)?  forbidden,TResult? Function( String? message)?  notFound,TResult? Function( Map<String, List<String>> errors,  String? message)?  validation,TResult? Function( int? code,  String? message)?  server,TResult? Function( String message)?  forceUpdate,TResult? Function( String message)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case CancelledFailure() when cancelled != null:
return cancelled();case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.message);case ForbiddenFailure() when forbidden != null:
return forbidden(_that.message);case NotFoundFailure() when notFound != null:
return notFound(_that.message);case ValidationFailure() when validation != null:
return validation(_that.errors,_that.message);case ServerFailure() when server != null:
return server(_that.code,_that.message);case ForceUpdateFailure() when forceUpdate != null:
return forceUpdate(_that.message);case UnknownFailure() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure extends Failure {
  const NetworkFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.network()';
}


}




/// @nodoc


class TimeoutFailure extends Failure {
  const TimeoutFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.timeout()';
}


}




/// @nodoc


class CancelledFailure extends Failure {
  const CancelledFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelledFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cancelled()';
}


}




/// @nodoc


class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([this.message]): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthorizedFailureCopyWith<UnauthorizedFailure> get copyWith => _$UnauthorizedFailureCopyWithImpl<UnauthorizedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.unauthorized(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnauthorizedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnauthorizedFailureCopyWith(UnauthorizedFailure value, $Res Function(UnauthorizedFailure) _then) = _$UnauthorizedFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$UnauthorizedFailureCopyWithImpl<$Res>
    implements $UnauthorizedFailureCopyWith<$Res> {
  _$UnauthorizedFailureCopyWithImpl(this._self, this._then);

  final UnauthorizedFailure _self;
  final $Res Function(UnauthorizedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(UnauthorizedFailure(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ForbiddenFailure extends Failure {
  const ForbiddenFailure([this.message]): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForbiddenFailureCopyWith<ForbiddenFailure> get copyWith => _$ForbiddenFailureCopyWithImpl<ForbiddenFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForbiddenFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.forbidden(message: $message)';
}


}

/// @nodoc
abstract mixin class $ForbiddenFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ForbiddenFailureCopyWith(ForbiddenFailure value, $Res Function(ForbiddenFailure) _then) = _$ForbiddenFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ForbiddenFailureCopyWithImpl<$Res>
    implements $ForbiddenFailureCopyWith<$Res> {
  _$ForbiddenFailureCopyWithImpl(this._self, this._then);

  final ForbiddenFailure _self;
  final $Res Function(ForbiddenFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ForbiddenFailure(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotFoundFailure extends Failure {
  const NotFoundFailure([this.message]): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundFailureCopyWith<NotFoundFailure> get copyWith => _$NotFoundFailureCopyWithImpl<NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.notFound(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NotFoundFailureCopyWith(NotFoundFailure value, $Res Function(NotFoundFailure) _then) = _$NotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$NotFoundFailureCopyWithImpl<$Res>
    implements $NotFoundFailureCopyWith<$Res> {
  _$NotFoundFailureCopyWithImpl(this._self, this._then);

  final NotFoundFailure _self;
  final $Res Function(NotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(NotFoundFailure(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ValidationFailure extends Failure {
  const ValidationFailure(final  Map<String, List<String>> errors, {this.message}): _errors = errors,super._();
  

 final  Map<String, List<String>> _errors;
 Map<String, List<String>> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors),message);

@override
String toString() {
  return 'Failure.validation(errors: $errors, message: $message)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@useResult
$Res call({
 Map<String, List<String>> errors, String? message
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errors = null,Object? message = freezed,}) {
  return _then(ValidationFailure(
null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ServerFailure extends Failure {
  const ServerFailure({this.code, this.message}): super._();
  

 final  int? code;
 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'Failure.server(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 int? code, String? message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(ServerFailure(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ForceUpdateFailure extends Failure {
  const ForceUpdateFailure(this.message): super._();
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForceUpdateFailureCopyWith<ForceUpdateFailure> get copyWith => _$ForceUpdateFailureCopyWithImpl<ForceUpdateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForceUpdateFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.forceUpdate(message: $message)';
}


}

/// @nodoc
abstract mixin class $ForceUpdateFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ForceUpdateFailureCopyWith(ForceUpdateFailure value, $Res Function(ForceUpdateFailure) _then) = _$ForceUpdateFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ForceUpdateFailureCopyWithImpl<$Res>
    implements $ForceUpdateFailureCopyWith<$Res> {
  _$ForceUpdateFailureCopyWithImpl(this._self, this._then);

  final ForceUpdateFailure _self;
  final $Res Function(ForceUpdateFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ForceUpdateFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownFailure extends Failure {
  const UnknownFailure(this.message): super._();
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UnknownFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
