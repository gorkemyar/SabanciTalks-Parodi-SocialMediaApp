import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/util/analytics.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();

  static const String routeName = '/home';
}

class _HomeViewState extends State<HomeView> {
  List<PostView> posts = [];
  List<dynamic> postsJSONs = [];

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    postsJSONs = await f.getFeedPostsByLimit(15, onlyFollowed: true);
    debugPrint("postsJSONs: ${postsJSONs}");
    // Get my uid to decide if I liked the posts before or not
    String myUid = await f.decideUser() ?? "";
    posts = [];
    for (dynamic post in postsJSONs) {
      // Get the post owner information by uid
      final userJSON = await f.getUser(post[1].uid);
      // Add post information to the view
      posts.add(PostView(
        postModel: PostModel(
            name: userJSON != null ? userJSON[1].fullName : "John Doe",
            date: post[1].createdAt,
            profileImg: userJSON != null
                ? userJSON[1].profilePicture
                : "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
            likeCount: post[1].likeArr.length,
            commentCount: 58,
            contentCount: post[1].pictureUrlArr.length,
            postText: post[1].postText,
            isLiked: post[1].likeArr.contains(myUid),
            postId: post[0],
            uid: post[1].uid,
            contents: post[1].pictureUrlArr.map<Content>((url) {
              return Content(
                type: "image",
                contentId: url,
                source: url,
              );
            }).toList()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Home Page");
    return FutureBuilder(
        future: getMyPost(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: const Text("Home page is loading")));
            default:
              return Scaffold(
                appBar: _appBar(),
                body: SizedBox(
                  width: double.infinity,
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: posts,
                  ),
                ),
              );
          }
        });
  }

  AppBar _appBar() => AppBar(
        title: const Text("Sabanci Talks"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () => NavigationService.instance
                .navigateToPage(path: NavigationConstants.CHAT_LIST),
          ),
        ],
      );
}
