import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';

class CommentWidget extends StatefulWidget {
  final String uid;
  final String comment;
  const CommentWidget({Key? key, required this.uid, required this.comment})
      : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<dynamic>? userJSON = [];

  Future<void> getCommentorUser() async {
    Firestore f = Firestore();
    userJSON = await f.getUser(widget.uid);
    debugPrint("userJSON $userJSON");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCommentorUser(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            // If the connection does not there state
            case ConnectionState.waiting:
              return ListTile(
                dense: true,
                leading: const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/profile_images/1498585975269830657/b3ac0hBJ_400x400.jpg',
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: '@Anonymous',
                    style: kHeader4TextStyle,
                    children: [
                      TextSpan(
                        text: widget.comment,
                        style: const TextStyle(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            default:
              return ListTile(
                dense: true,
                leading:  CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage((userJSON != null ? userJSON![1].profilePicture :'https://pbs.twimg.com/profile_images/1498585975269830657/b3ac0hBJ_400x400.jpg')),
                ),
                title: RichText(
                  text: TextSpan(
                    text: userJSON != null ? userJSON![1].fullName: "",
                    style: kHeader4TextStyle,
                    children: [
                      const TextSpan(
                        text: "    ",
                        style: TextStyle(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      TextSpan(
                        text: widget.comment,
                        style: const TextStyle(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        }));
  }
}


/* 
return ListTile(
      dense: true,
      leading: const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://pbs.twimg.com/profile_images/1498585975269830657/b3ac0hBJ_400x400.jpg',
        ),
      ),
      title: RichText(
        text: TextSpan(
          text: '@Carlossainz55 ',
          style: kHeader4TextStyle,
          children:  [
            TextSpan(
              text: widget.comment,
              style: const TextStyle(
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    ); */