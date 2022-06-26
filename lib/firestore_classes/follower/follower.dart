import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'follower.g.dart';
part 'follower.freezed.dart';

@Freezed()
class Follower with _$Follower {
  const factory Follower({
    required String uid,
    @Default([]) followers,
  }) = _Follower;

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
}
