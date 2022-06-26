// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notifications _$$_NotificationsFromJson(Map<String, dynamic> json) =>
    _$_Notifications(
      uid: json['uid'] as String,
      notification_type: json['notification_type'] ?? "",
      uid_sub: json['uid_sub'] ?? "",
      isPost: json['isPost'] ?? false,
      postId: json['postId'] ?? "",
    );

Map<String, dynamic> _$$_NotificationsToJson(_$_Notifications instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'notification_type': instance.notification_type,
      'uid_sub': instance.uid_sub,
      'isPost': instance.isPost,
      'postId': instance.postId,
    };
