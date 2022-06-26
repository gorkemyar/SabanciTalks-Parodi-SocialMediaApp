import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'request.g.dart';
part 'request.freezed.dart';

@Freezed()
class Request with _$Request {
  const factory Request({
    required String uid,
    @Default([]) requests,
  }) = _Request;

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}
