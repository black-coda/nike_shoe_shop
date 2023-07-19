// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfoPayload _$UserInfoPayloadFromJson(Map<String, dynamic> json) {
  return _UserInfoPayload.fromJson(json);
}

/// @nodoc
mixin _$UserInfoPayload {
  String get userId => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoPayloadCopyWith<UserInfoPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoPayloadCopyWith<$Res> {
  factory $UserInfoPayloadCopyWith(
          UserInfoPayload value, $Res Function(UserInfoPayload) then) =
      _$UserInfoPayloadCopyWithImpl<$Res, UserInfoPayload>;
  @useResult
  $Res call(
      {String userId, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class _$UserInfoPayloadCopyWithImpl<$Res, $Val extends UserInfoPayload>
    implements $UserInfoPayloadCopyWith<$Res> {
  _$UserInfoPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserInfoPayloadCopyWith<$Res>
    implements $UserInfoPayloadCopyWith<$Res> {
  factory _$$_UserInfoPayloadCopyWith(
          _$_UserInfoPayload value, $Res Function(_$_UserInfoPayload) then) =
      __$$_UserInfoPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class __$$_UserInfoPayloadCopyWithImpl<$Res>
    extends _$UserInfoPayloadCopyWithImpl<$Res, _$_UserInfoPayload>
    implements _$$_UserInfoPayloadCopyWith<$Res> {
  __$$_UserInfoPayloadCopyWithImpl(
      _$_UserInfoPayload _value, $Res Function(_$_UserInfoPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$_UserInfoPayload(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfoPayload implements _UserInfoPayload {
  const _$_UserInfoPayload(
      {required this.userId,
      required this.displayName,
      required this.email,
      this.photoUrl});

  factory _$_UserInfoPayload.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoPayloadFromJson(json);

  @override
  final String userId;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'UserInfoPayload(userId: $userId, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfoPayload &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, email, photoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoPayloadCopyWith<_$_UserInfoPayload> get copyWith =>
      __$$_UserInfoPayloadCopyWithImpl<_$_UserInfoPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoPayloadToJson(
      this,
    );
  }
}

abstract class _UserInfoPayload implements UserInfoPayload {
  const factory _UserInfoPayload(
      {required final String userId,
      required final String? displayName,
      required final String? email,
      final String? photoUrl}) = _$_UserInfoPayload;

  factory _UserInfoPayload.fromJson(Map<String, dynamic> json) =
      _$_UserInfoPayload.fromJson;

  @override
  String get userId;
  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoPayloadCopyWith<_$_UserInfoPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
