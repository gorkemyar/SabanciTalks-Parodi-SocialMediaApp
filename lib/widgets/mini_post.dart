import 'package:flutter/material.dart';
import 'dart:io';

class MiniPost extends StatelessWidget {
  final String url;
  final bool isNetworkImg;
  const MiniPost(this.url, {Key? key, this.isNetworkImg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNetworkImg) {
      return Image.network(url, fit: BoxFit.fill);
    } else {
      return Image.file(File(url));
    }
  }
}
