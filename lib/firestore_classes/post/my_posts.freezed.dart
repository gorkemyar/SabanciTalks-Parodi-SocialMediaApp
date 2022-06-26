// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_posts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyPost _$MyPostFromJson(Map<String, dynamic> json) {
  return _MyPost.fromJson(json);
}

/// @nodoc
mixin _$MyPost {
  String get uid => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get postText => throw _privateConstructorUsedError;
  List<String> get pictureUrlArr => throw _privateConstructorUsedError;
  List<String> get likeArr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyPostCopyWith<MyPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPostCopyWith<$Res> {
  factory $MyPostCopyWith(MyPost value, $Res Function(MyPost) then) =
      _$MyPostCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String createdAt,
      String postText,
      List<String> pictureUrlArr,
      List<String> likeArr});
}

/// @nodoc
class _$MyPostCopyWithImpl<$Res> implements $MyPostCopyWith<$Res> {
  _$MyPostCopyWithImpl(this._value, this._then);

  final MyPost _value;
  // ignore: unused_field
  final $Res Function(MyPost) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? createdAt = freezed,
    Object? postText = freezed,
    Object? pictureUrlArr = freezed,
    Object? likeArr = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      postText: postText == freezed
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrlArr: pictureUrlArr == freezed
          ? _value.pictureUrlArr
          : pictureUrlArr // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeArr: likeArr == freezed
          ? _value.likeArr
          : likeArr // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_MyPostCopyWith<$Res> implements $MyPostCopyWith<$Res> {
  factory _$$_MyPostCopyWith(_$_MyPost value, $Res Function(_$_MyPost) then) =
      __$$_MyPostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String createdAt,
      String postText,
      List<String> pictureUrlArr,
      List<String> likeArr});
}

/// @nodoc
class __$$_MyPostCopyWithImpl<$Res> extends _$MyPostCopyWithImpl<$Res>
    implements _$$_MyPostCopyWith<$Res> {
  __$$_MyPostCopyWithImpl(_$_MyPost _value, $Res Function(_$_MyPost) _then)
      : super(_value, (v) => _then(v as _$_MyPost));

  @override
  _$_MyPost get _value => super._value as _$_MyPost;

  @override
  $Res call({
    Object? uid = freezed,
    Object? createdAt = freezed,
    Object? postText = freezed,
    Object? pictureUrlArr = freezed,
    Object? likeArr = freezed,
  }) {
    return _then(_$_MyPost(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      postText: postText == freezed
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrlArr: pictureUrlArr == freezed
          ? _value._pictureUrlArr
          : pictureUrlArr // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeArr: likeArr == freezed
          ? _value._likeArr
          : likeArr // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyPost implements _MyPost {
  _$_MyPost(
      {required this.uid,
      this.createdAt = "2022-06-07-22:48",
      this.postText = "empty",
      final List<String> pictureUrlArr = const ["https://picsum.photos/600"],
      final List<String> likeArr = const []})
      : _pictureUrlArr = pictureUrlArr,
        _likeArr = likeArr;

  factory _$_MyPost.fromJson(Map<String, dynamic> json) =>
      _$$_MyPostFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String postText;
  final List<String> _pictureUrlArr;
  @override
  @JsonKey()
  List<String> get pictureUrlArr {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictureUrlArr);
  }

  final List<String> _likeArr;
  @override
  @JsonKey()
  List<String> get likeArr {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeArr);
  }

  @override
  String toString() {
    return 'MyPost(uid: $uid, createdAt: $createdAt, postText: $postText, pictureUrlArr: $pictureUrlArr, likeArr: $likeArr)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyPost &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.postText, postText) &&
            const DeepCollectionEquality()
                .equals(other._pictureUrlArr, _pictureUrlArr) &&
            const DeepCollectionEquality().equals(other._likeArr, _likeArr));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(postText),
      const DeepCollectionEquality().hash(_pictureUrlArr),
      const DeepCollectionEquality().hash(_likeArr));

  @JsonKey(ignore: true)
  @override
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      __$$_MyPostCopyWithImpl<_$_MyPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyPostToJson(this);
  }
}

abstract class _MyPost implements MyPost {
  factory _MyPost(
      {required final String uid,
      final String createdAt,
      final String postText,
      final List<String> pictureUrlArr,
      final List<String> likeArr}) = _$_MyPost;

  factory _MyPost.fromJson(Map<String, dynamic> json) = _$_MyPost.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get createdAt => throw _privateConstructorUsedError;
  @override
  String get postText => throw _privateConstructorUsedError;
  @override
  List<String> get pictureUrlArr => throw _privateConstructorUsedError;
  @override
  List<String> get likeArr => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      throw _privateConstructorUsedError;
}
