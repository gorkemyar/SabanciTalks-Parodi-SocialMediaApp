import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_posts.g.dart';
part 'my_posts.freezed.dart';

@Freezed()
class MyPost with _$MyPost {
  factory MyPost({
    required String uid,
    @Default("2022-06-07-22:48")
        String createdAt,
    @Default("empty")
        String postText,
    @Default([
      "https://picsum.photos/600",
    ])
        List<String> pictureUrlArr,
    @Default([])
        List<String> likeArr,
  }) = _MyPost;

  factory MyPost.fromJson(Map<String, dynamic> json) => _$MyPostFromJson(json);
}
