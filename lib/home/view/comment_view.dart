import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/widgets/comment_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  const Comments({Key? key, required this.postId, required this.postOwnerId})
      : super(key: key);

  static const String routeName = '/comments';

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late TextEditingController controller;
  List<dynamic> commentsJSON = [];
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  Future<void> getComments() async {
    Firestore f = Firestore();
    commentsJSON = await f.getAllComments(widget.postId);
    debugPrint("commentsJSON $commentsJSON");
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Comment Page");
    return FutureBuilder(
        future: getComments(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: const Text("Comments are loading")));
            default:
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Comments'),
                  ),
                  body: _body());
          }
        });
  }

  SafeArea _body() => SafeArea(
          child: Column(
        children: [
          _comments(),
          _footer(),
        ],
      ));

  Expanded _comments() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shrinkWrap: false,
        itemBuilder: (context, index) => CommentWidget(
          comment: commentsJSON[index][1].comment,
          uid: commentsJSON[index][1].uid,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: commentsJSON.length,
      ),
    );
  }

  Container _footer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 16),
          _commentInput(),
          const SizedBox(width: 4),
          _sendCommentIcon()
        ],
      ),
    );
  }

  IconButton _sendCommentIcon() {
    return IconButton(
        icon: const Icon(
          Icons.send,
          color: AppColors.secondary,
        ),
        onPressed: () async {
          var prefs = await SharedPreferences.getInstance();
          String? uid = prefs.getString('user');
          if (uid == null) {
            return;
          }
          Firestore f = Firestore();
          await f.addComment(
              commentText: controller.text, postid: widget.postId, uid: uid);
          await f.addNotification(
              uid: widget.postOwnerId,
              notification_type: "comment",
              uid_sub: uid,
              isPost: true,
              postId: widget.postId);
          setState(() {});
          debugPrint("comment ${controller.text}");

          controller.text = "";
        });
  }

  Expanded _commentInput() => Expanded(
        child: Container(
          height: 48,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.darkGrey, width: 1)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: controller,
            autocorrect: false,
            enableSuggestions: false,
            autofocus: false,
            decoration: const InputDecoration(
                hintText: "Add a comment",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.all(0)),
          ),
        ),
      );
}
