import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'following.g.dart';
part 'following.freezed.dart';

@Freezed()
class Following with _$Following {
  const factory Following({
    required String uid,
    @Default([]) followings,
  }) = _Following;

  factory Following.fromJson(Map<String, dynamic> json) =>
      _$FollowingFromJson(json);
}
