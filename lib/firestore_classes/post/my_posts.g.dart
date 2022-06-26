// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyPost _$$_MyPostFromJson(Map<String, dynamic> json) => _$_MyPost(
      uid: json['uid'] as String,
      createdAt: json['createdAt'] as String? ?? "2022-06-07-22:48",
      postText: json['postText'] as String? ?? "empty",
      pictureUrlArr: (json['pictureUrlArr'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ["https://picsum.photos/600"],
      likeArr: (json['likeArr'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_MyPostToJson(_$_MyPost instance) => <String, dynamic>{
      'uid': instance.uid,
      'createdAt': instance.createdAt,
      'postText': instance.postText,
      'pictureUrlArr': instance.pictureUrlArr,
      'likeArr': instance.likeArr,
    };
