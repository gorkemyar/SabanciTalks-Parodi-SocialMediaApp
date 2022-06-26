// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyComment _$MyCommentFromJson(Map<String, dynamic> json) {
  return _MyComment.fromJson(json);
}

/// @nodoc
mixin _$MyComment {
  String get postid => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyCommentCopyWith<MyComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyCommentCopyWith<$Res> {
  factory $MyCommentCopyWith(MyComment value, $Res Function(MyComment) then) =
      _$MyCommentCopyWithImpl<$Res>;
  $Res call({String postid, String uid, String comment});
}

/// @nodoc
class _$MyCommentCopyWithImpl<$Res> implements $MyCommentCopyWith<$Res> {
  _$MyCommentCopyWithImpl(this._value, this._then);

  final MyComment _value;
  // ignore: unused_field
  final $Res Function(MyComment) _then;

  @override
  $Res call({
    Object? postid = freezed,
    Object? uid = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      postid: postid == freezed
          ? _value.postid
          : postid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MyCommentCopyWith<$Res> implements $MyCommentCopyWith<$Res> {
  factory _$$_MyCommentCopyWith(
          _$_MyComment value, $Res Function(_$_MyComment) then) =
      __$$_MyCommentCopyWithImpl<$Res>;
  @override
  $Res call({String postid, String uid, String comment});
}

/// @nodoc
class __$$_MyCommentCopyWithImpl<$Res> extends _$MyCommentCopyWithImpl<$Res>
    implements _$$_MyCommentCopyWith<$Res> {
  __$$_MyCommentCopyWithImpl(
      _$_MyComment _value, $Res Function(_$_MyComment) _then)
      : super(_value, (v) => _then(v as _$_MyComment));

  @override
  _$_MyComment get _value => super._value as _$_MyComment;

  @override
  $Res call({
    Object? postid = freezed,
    Object? uid = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$_MyComment(
      postid: postid == freezed
          ? _value.postid
          : postid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyComment implements _MyComment {
  _$_MyComment(
      {required this.postid, this.uid = "uid", this.comment = "comment"});

  factory _$_MyComment.fromJson(Map<String, dynamic> json) =>
      _$$_MyCommentFromJson(json);

  @override
  final String postid;
  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String comment;

  @override
  String toString() {
    return 'MyComment(postid: $postid, uid: $uid, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyComment &&
            const DeepCollectionEquality().equals(other.postid, postid) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.comment, comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(postid),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(comment));

  @JsonKey(ignore: true)
  @override
  _$$_MyCommentCopyWith<_$_MyComment> get copyWith =>
      __$$_MyCommentCopyWithImpl<_$_MyComment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyCommentToJson(this);
  }
}

abstract class _MyComment implements MyComment {
  factory _MyComment(
      {required final String postid,
      final String uid,
      final String comment}) = _$_MyComment;

  factory _MyComment.fromJson(Map<String, dynamic> json) =
      _$_MyComment.fromJson;

  @override
  String get postid => throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get comment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyCommentCopyWith<_$_MyComment> get copyWith =>
      throw _privateConstructorUsedError;
}
