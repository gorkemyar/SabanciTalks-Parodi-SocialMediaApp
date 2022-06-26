
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_comment.g.dart';
part 'my_comment.freezed.dart';


@Freezed()
class MyComment with _$MyComment {
  factory MyComment({
    required String postid,
    @Default("uid")
      String uid,
    @Default("comment")
        String comment,
  }) = _MyComment;

  factory MyComment.fromJson(Map<String, dynamic> json) => _$MyCommentFromJson(json);
}
