import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/edit_post.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';

class SinglePost extends StatefulWidget {
  const SinglePost(
      {Key? key,
      required this.docId,
      required this.proUrl,
      required this.name,
      required this.date})
      : super(key: key);
  final String docId;
  final String proUrl;
  final String name;
  final String date;

  @override
  State<SinglePost> createState() => _SinglePostState();

  static const String routeName = '/singlePost';
}

class _SinglePostState extends State<SinglePost> {
  MyPost? post;
  List<Content> contents = [];
  bool isButtonActive = true;
  bool isNotDeleted = true;

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    post = isNotDeleted ? await f.getSpecificPost(widget.docId) : MyPost(uid: "uid");

    contents = [];
    for (String url in post!.pictureUrlArr) {
      contents.add(Content(
        type: "image",
        contentId: url,
        source: url,
      ));
    }
  }

  Future deletePost() async{
    setState(() {
      isNotDeleted = false;
      isButtonActive = false;
    });

    Firestore f = Firestore();
    NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
    
    await f.deletePost(widget.docId);
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMyPost(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        });
  }

  AppBar _appBar() => AppBar(
        title: const Text("Post Details"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => EditPost(
                  proUrl: widget.proUrl,
                  docId: widget.docId,
                  name: widget.name,
                  oldDescription: post != null ? post!.postText: "",
                  )),
              );


            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: isButtonActive
              ? () {
                deletePost();
              }: (){
                Fluttertoast.showToast(
                      msg: "Please wait until the post is deleting",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
              }
          ),
        ],
      );

  SizedBox _body() {
    debugPrint("contents $contents");
    return SizedBox(
      width: double.infinity,
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          PostView(
            postModel: PostModel(
              name: widget.name,
              date: widget.date,
              profileImg: widget.proUrl,
              likeCount: post != null ? post!.likeArr.length : 0,
              commentCount: 58,
              contentCount: contents.length,
              postText: post != null ? post!.postText : "",
              contents: contents,
              postId: widget.docId,
            ),
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
