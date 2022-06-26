// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$$_MyUserFromJson(Map<String, dynamic> json) => _$_MyUser(
      uid: json['uid'] as String,
      fullName: json['fullName'] ?? "John Doe",
      gender: json['gender'] as String? ?? 'Male',
      private: json['private'] ?? false,
      biography: json['biography'] ?? 'Your biography',
      profilePicture: json['profilePicture'] ?? 'emptypic.jpg',
      postCount: json['postCount'] ?? 0,
      following: json['following'] ?? 0,
      follower: json['follower'] ?? 0,
    );

Map<String, dynamic> _$$_MyUserToJson(_$_MyUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'private': instance.private,
      'biography': instance.biography,
      'profilePicture': instance.profilePicture,
      'postCount': instance.postCount,
      'following': instance.following,
      'follower': instance.follower,
    };
