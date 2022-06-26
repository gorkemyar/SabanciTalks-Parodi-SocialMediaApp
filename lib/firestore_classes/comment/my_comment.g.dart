// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyComment _$$_MyCommentFromJson(Map<String, dynamic> json) => _$_MyComment(
      postid: json['postid'] as String,
      uid: json['uid'] as String? ?? "uid",
      comment: json['comment'] as String? ?? "comment",
    );

Map<String, dynamic> _$$_MyCommentToJson(_$_MyComment instance) =>
    <String, dynamic>{
      'postid': instance.postid,
      'uid': instance.uid,
      'comment': instance.comment,
    };
