// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyUser _$MyUserFromJson(Map<String, dynamic> json) {
  return _MyUser.fromJson(json);
}

/// @nodoc
mixin _$MyUser {
  String get uid => throw _privateConstructorUsedError;
  dynamic get fullName => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  dynamic get private => throw _privateConstructorUsedError;
  dynamic get biography => throw _privateConstructorUsedError;
  dynamic get profilePicture => throw _privateConstructorUsedError;
  dynamic get postCount => throw _privateConstructorUsedError;
  dynamic get following => throw _privateConstructorUsedError;
  dynamic get follower => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyUserCopyWith<MyUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyUserCopyWith<$Res> {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) then) =
      _$MyUserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      dynamic fullName,
      String gender,
      dynamic private,
      dynamic biography,
      dynamic profilePicture,
      dynamic postCount,
      dynamic following,
      dynamic follower});
}

/// @nodoc
class _$MyUserCopyWithImpl<$Res> implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._value, this._then);

  final MyUser _value;
  // ignore: unused_field
  final $Res Function(MyUser) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? gender = freezed,
    Object? private = freezed,
    Object? biography = freezed,
    Object? profilePicture = freezed,
    Object? postCount = freezed,
    Object? following = freezed,
    Object? follower = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      private: private == freezed
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as dynamic,
      biography: biography == freezed
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as dynamic,
      profilePicture: profilePicture == freezed
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCount: postCount == freezed
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as dynamic,
      follower: follower == freezed
          ? _value.follower
          : follower // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_MyUserCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$$_MyUserCopyWith(_$_MyUser value, $Res Function(_$_MyUser) then) =
      __$$_MyUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      dynamic fullName,
      String gender,
      dynamic private,
      dynamic biography,
      dynamic profilePicture,
      dynamic postCount,
      dynamic following,
      dynamic follower});
}

/// @nodoc
class __$$_MyUserCopyWithImpl<$Res> extends _$MyUserCopyWithImpl<$Res>
    implements _$$_MyUserCopyWith<$Res> {
  __$$_MyUserCopyWithImpl(_$_MyUser _value, $Res Function(_$_MyUser) _then)
      : super(_value, (v) => _then(v as _$_MyUser));

  @override
  _$_MyUser get _value => super._value as _$_MyUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? gender = freezed,
    Object? private = freezed,
    Object? biography = freezed,
    Object? profilePicture = freezed,
    Object? postCount = freezed,
    Object? following = freezed,
    Object? follower = freezed,
  }) {
    return _then(_$_MyUser(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed ? _value.fullName : fullName,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      private: private == freezed ? _value.private : private,
      biography: biography == freezed ? _value.biography : biography,
      profilePicture:
          profilePicture == freezed ? _value.profilePicture : profilePicture,
      postCount: postCount == freezed ? _value.postCount : postCount,
      following: following == freezed ? _value.following : following,
      follower: follower == freezed ? _value.follower : follower,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyUser implements _MyUser {
  const _$_MyUser(
      {required this.uid,
      this.fullName = "John Doe",
      this.gender = 'Male',
      this.private = false,
      this.biography = 'Your biography',
      this.profilePicture = 'emptypic.jpg',
      this.postCount = 0,
      this.following = 0,
      this.follower = 0});

  factory _$_MyUser.fromJson(Map<String, dynamic> json) =>
      _$$_MyUserFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final dynamic fullName;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final dynamic private;
  @override
  @JsonKey()
  final dynamic biography;
  @override
  @JsonKey()
  final dynamic profilePicture;
  @override
  @JsonKey()
  final dynamic postCount;
  @override
  @JsonKey()
  final dynamic following;
  @override
  @JsonKey()
  final dynamic follower;

  @override
  String toString() {
    return 'MyUser(uid: $uid, fullName: $fullName, gender: $gender, private: $private, biography: $biography, profilePicture: $profilePicture, postCount: $postCount, following: $following, follower: $follower)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyUser &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.private, private) &&
            const DeepCollectionEquality().equals(other.biography, biography) &&
            const DeepCollectionEquality()
                .equals(other.profilePicture, profilePicture) &&
            const DeepCollectionEquality().equals(other.postCount, postCount) &&
            const DeepCollectionEquality().equals(other.following, following) &&
            const DeepCollectionEquality().equals(other.follower, follower));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(private),
      const DeepCollectionEquality().hash(biography),
      const DeepCollectionEquality().hash(profilePicture),
      const DeepCollectionEquality().hash(postCount),
      const DeepCollectionEquality().hash(following),
      const DeepCollectionEquality().hash(follower));

  @JsonKey(ignore: true)
  @override
  _$$_MyUserCopyWith<_$_MyUser> get copyWith =>
      __$$_MyUserCopyWithImpl<_$_MyUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyUserToJson(this);
  }
}

abstract class _MyUser implements MyUser {
  const factory _MyUser(
      {required final String uid,
      final dynamic fullName,
      final String gender,
      final dynamic private,
      final dynamic biography,
      final dynamic profilePicture,
      final dynamic postCount,
      final dynamic following,
      final dynamic follower}) = _$_MyUser;

  factory _MyUser.fromJson(Map<String, dynamic> json) = _$_MyUser.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  dynamic get fullName => throw _privateConstructorUsedError;
  @override
  String get gender => throw _privateConstructorUsedError;
  @override
  dynamic get private => throw _privateConstructorUsedError;
  @override
  dynamic get biography => throw _privateConstructorUsedError;
  @override
  dynamic get profilePicture => throw _privateConstructorUsedError;
  @override
  dynamic get postCount => throw _privateConstructorUsedError;
  @override
  dynamic get following => throw _privateConstructorUsedError;
  @override
  dynamic get follower => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyUserCopyWith<_$_MyUser> get copyWith =>
      throw _privateConstructorUsedError;
}
