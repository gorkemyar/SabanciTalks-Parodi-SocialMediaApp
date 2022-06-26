import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification.g.dart';
part 'notification.freezed.dart';

@Freezed()
class Notifications with _$Notifications {
  const factory Notifications({
    required String uid,
    @Default("") notification_type,
    @Default("") uid_sub,
    @Default(false) isPost,
    @Default("") postId,
  }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
}
