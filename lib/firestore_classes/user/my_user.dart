import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_user.g.dart';
part 'my_user.freezed.dart';


@Freezed()
class MyUser with _$MyUser {
  const factory MyUser({
    required String uid,
    @Default("John Doe") fullName,
    @Default('Male') String gender,
    @Default(false) private,
    @Default('Your biography') biography,
    @Default('emptypic.jpg') profilePicture,
    @Default(0) postCount,
    @Default(0) following,
    @Default(0) follower,

  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
