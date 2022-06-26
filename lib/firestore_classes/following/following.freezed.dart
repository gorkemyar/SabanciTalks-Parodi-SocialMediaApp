// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'following.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Following _$FollowingFromJson(Map<String, dynamic> json) {
  return _Following.fromJson(json);
}

/// @nodoc
mixin _$Following {
  String get uid => throw _privateConstructorUsedError;
  dynamic get followings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FollowingCopyWith<Following> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowingCopyWith<$Res> {
  factory $FollowingCopyWith(Following value, $Res Function(Following) then) =
      _$FollowingCopyWithImpl<$Res>;
  $Res call({String uid, dynamic followings});
}

/// @nodoc
class _$FollowingCopyWithImpl<$Res> implements $FollowingCopyWith<$Res> {
  _$FollowingCopyWithImpl(this._value, this._then);

  final Following _value;
  // ignore: unused_field
  final $Res Function(Following) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? followings = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followings: followings == freezed
          ? _value.followings
          : followings // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_FollowingCopyWith<$Res> implements $FollowingCopyWith<$Res> {
  factory _$$_FollowingCopyWith(
          _$_Following value, $Res Function(_$_Following) then) =
      __$$_FollowingCopyWithImpl<$Res>;
  @override
  $Res call({String uid, dynamic followings});
}

/// @nodoc
class __$$_FollowingCopyWithImpl<$Res> extends _$FollowingCopyWithImpl<$Res>
    implements _$$_FollowingCopyWith<$Res> {
  __$$_FollowingCopyWithImpl(
      _$_Following _value, $Res Function(_$_Following) _then)
      : super(_value, (v) => _then(v as _$_Following));

  @override
  _$_Following get _value => super._value as _$_Following;

  @override
  $Res call({
    Object? uid = freezed,
    Object? followings = freezed,
  }) {
    return _then(_$_Following(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      followings: followings == freezed ? _value.followings : followings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Following implements _Following {
  const _$_Following({required this.uid, this.followings = const []});

  factory _$_Following.fromJson(Map<String, dynamic> json) =>
      _$$_FollowingFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final dynamic followings;

  @override
  String toString() {
    return 'Following(uid: $uid, followings: $followings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Following &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.followings, followings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(followings));

  @JsonKey(ignore: true)
  @override
  _$$_FollowingCopyWith<_$_Following> get copyWith =>
      __$$_FollowingCopyWithImpl<_$_Following>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FollowingToJson(this);
  }
}

abstract class _Following implements Following {
  const factory _Following(
      {required final String uid, final dynamic followings}) = _$_Following;

  factory _Following.fromJson(Map<String, dynamic> json) =
      _$_Following.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  dynamic get followings => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FollowingCopyWith<_$_Following> get copyWith =>
      throw _privateConstructorUsedError;
}
