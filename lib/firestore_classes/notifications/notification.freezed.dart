// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return _Notifications.fromJson(json);
}

/// @nodoc
mixin _$Notifications {
  String get uid => throw _privateConstructorUsedError;
  dynamic get notification_type => throw _privateConstructorUsedError;
  dynamic get uid_sub => throw _privateConstructorUsedError;
  dynamic get isPost => throw _privateConstructorUsedError;
  dynamic get postId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsCopyWith<Notifications> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsCopyWith<$Res> {
  factory $NotificationsCopyWith(
          Notifications value, $Res Function(Notifications) then) =
      _$NotificationsCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      dynamic notification_type,
      dynamic uid_sub,
      dynamic isPost,
      dynamic postId});
}

/// @nodoc
class _$NotificationsCopyWithImpl<$Res>
    implements $NotificationsCopyWith<$Res> {
  _$NotificationsCopyWithImpl(this._value, this._then);

  final Notifications _value;
  // ignore: unused_field
  final $Res Function(Notifications) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? notification_type = freezed,
    Object? uid_sub = freezed,
    Object? isPost = freezed,
    Object? postId = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      notification_type: notification_type == freezed
          ? _value.notification_type
          : notification_type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid_sub: uid_sub == freezed
          ? _value.uid_sub
          : uid_sub // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isPost: isPost == freezed
          ? _value.isPost
          : isPost // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_NotificationsCopyWith<$Res>
    implements $NotificationsCopyWith<$Res> {
  factory _$$_NotificationsCopyWith(
          _$_Notifications value, $Res Function(_$_Notifications) then) =
      __$$_NotificationsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      dynamic notification_type,
      dynamic uid_sub,
      dynamic isPost,
      dynamic postId});
}

/// @nodoc
class __$$_NotificationsCopyWithImpl<$Res>
    extends _$NotificationsCopyWithImpl<$Res>
    implements _$$_NotificationsCopyWith<$Res> {
  __$$_NotificationsCopyWithImpl(
      _$_Notifications _value, $Res Function(_$_Notifications) _then)
      : super(_value, (v) => _then(v as _$_Notifications));

  @override
  _$_Notifications get _value => super._value as _$_Notifications;

  @override
  $Res call({
    Object? uid = freezed,
    Object? notification_type = freezed,
    Object? uid_sub = freezed,
    Object? isPost = freezed,
    Object? postId = freezed,
  }) {
    return _then(_$_Notifications(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      notification_type: notification_type == freezed
          ? _value.notification_type
          : notification_type,
      uid_sub: uid_sub == freezed ? _value.uid_sub : uid_sub,
      isPost: isPost == freezed ? _value.isPost : isPost,
      postId: postId == freezed ? _value.postId : postId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Notifications implements _Notifications {
  const _$_Notifications(
      {required this.uid,
      this.notification_type = "",
      this.uid_sub = "",
      this.isPost = false,
      this.postId = ""});

  factory _$_Notifications.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationsFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final dynamic notification_type;
  @override
  @JsonKey()
  final dynamic uid_sub;
  @override
  @JsonKey()
  final dynamic isPost;
  @override
  @JsonKey()
  final dynamic postId;

  @override
  String toString() {
    return 'Notifications(uid: $uid, notification_type: $notification_type, uid_sub: $uid_sub, isPost: $isPost, postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Notifications &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.notification_type, notification_type) &&
            const DeepCollectionEquality().equals(other.uid_sub, uid_sub) &&
            const DeepCollectionEquality().equals(other.isPost, isPost) &&
            const DeepCollectionEquality().equals(other.postId, postId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(notification_type),
      const DeepCollectionEquality().hash(uid_sub),
      const DeepCollectionEquality().hash(isPost),
      const DeepCollectionEquality().hash(postId));

  @JsonKey(ignore: true)
  @override
  _$$_NotificationsCopyWith<_$_Notifications> get copyWith =>
      __$$_NotificationsCopyWithImpl<_$_Notifications>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationsToJson(this);
  }
}

abstract class _Notifications implements Notifications {
  const factory _Notifications(
      {required final String uid,
      final dynamic notification_type,
      final dynamic uid_sub,
      final dynamic isPost,
      final dynamic postId}) = _$_Notifications;

  factory _Notifications.fromJson(Map<String, dynamic> json) =
      _$_Notifications.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  dynamic get notification_type => throw _privateConstructorUsedError;
  @override
  dynamic get uid_sub => throw _privateConstructorUsedError;
  @override
  dynamic get isPost => throw _privateConstructorUsedError;
  @override
  dynamic get postId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationsCopyWith<_$_Notifications> get copyWith =>
      throw _privateConstructorUsedError;
}
