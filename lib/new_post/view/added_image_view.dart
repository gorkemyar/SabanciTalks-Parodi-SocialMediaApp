import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';

class AddedImageView extends StatelessWidget {
  final String url;
  final isNetworkImg;
  const AddedImageView(this.url, {Key? key, this.isNetworkImg = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              height: 108,
              child: MiniPost(url, isNetworkImg: isNetworkImg)),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Icon(Icons.remove_circle, color: AppColors.secondary,),
          )
        ],
      ),
    );
  }
}
