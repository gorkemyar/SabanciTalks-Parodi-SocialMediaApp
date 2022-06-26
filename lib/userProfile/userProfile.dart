import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';

//import 'package:sabanci_talks/firestore_classes/user/user.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/post/view/single_post.dart';

import 'package:sabanci_talks/profile/view/edit_profile.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/profile/view/profile_view.dart';
import 'package:sabanci_talks/settings/view/settings_view.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../post/model/post_model.dart';
import '../../post/view/post_view.dart';
import "package:sabanci_talks/firestore_classes/firestore_main/firestore.dart";

class UserProfileView extends StatefulWidget {
  UserProfileView(
      {Key? key,
      required this.uid,
      required this.isPrivate,
      required this.isFollowed,
      required this.refresher})
      : super(key: key);
  final String uid;
  final bool isPrivate;
  bool isFollowed;

  VoidCallback refresher;
  @override
  State<UserProfileView> createState() => _UserProfileView();
  static String routeName = '/UserProfileView';
}

class _UserProfileView extends State<UserProfileView>
    with SingleTickerProviderStateMixin {
  final dataKey = GlobalKey();
  dynamic myUser;
  MyUser? myUserFromJson;

  dynamic show;
  dynamic posts;
  dynamic followers;
  dynamic followings;
  Firestore f = Firestore();
  dynamic miniPostList;
  dynamic miniTextList;
  int idx = -1;
  List<MyPost> miniPostListJustPost = [];
  List<MyPost> miniTextListJustPost = [];
  dynamic personalUid;
  dynamic isWaiting;
  bool isFollowed = true;
  bool isPrivate = true;
  Future<void> getUser() async {
    idx = -1;
    miniPostListJustPost = [];
    miniTextListJustPost = [];
    personalUid = await f.decideUser();
    show = await f.getUser(widget.uid);

    isFollowed = await f.isFollowed(personalUid, widget.uid);
    isPrivate = await f.isPrivate(widget.uid);
    isWaiting = await f.isRequested(widget.uid, personalUid);
    posts = await f.getPost(widget.uid);
    followers = await f.getFollowers(widget.uid);
    followings = await f.getFollowings(widget.uid);
    miniPostList = posts != null
        ? posts.where((i) {
            if (i[1].pictureUrlArr.length != 0) {
              miniPostListJustPost.add(i[1]);
            } else {
              miniTextListJustPost.add(i[1]);
            }
            return i[1].pictureUrlArr.length != 0;
          }).toList()
        : [];
    miniTextList = posts != null
        ? posts.where((i) => i[1].pictureUrlArr.length == 0).toList()
        : [];
  }

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  Future<void> changeFollowing() async {
    if (isFollowed == true) {
      await f.unFollow(widget.uid, personalUid);

      await f.deleteFollowing(personalUid, widget.uid);
      debugPrint("helllooooooo is ${isFollowed}");
      setState(() {
        isFollowed = false;
      });
    } else {
      if (widget.isPrivate == true) {
        await f.addRequest(widget.uid, personalUid);
        await f.addNotification(
            uid: widget.uid,
            notification_type: "request",
            uid_sub: personalUid,
            isPost: false,
            postId: "");
        setState(() {
          isWaiting = true;
        });
      } else {
        await f.addFollow(widget.uid, personalUid);
        await f.addFollowing(personalUid, widget.uid);
        await f.addNotification(
            uid: widget.uid,
            notification_type: "follow",
            uid_sub: personalUid,
            isPost: false,
            postId: "");
        setState(() {
          isFollowed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("User Profile View");
    debugPrint("widget.uid is ${widget.uid}");
    debugPrint("helllooooooo is ${widget.isPrivate}");
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: const BackButton(color: Colors.white),
            ),
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: Dimen.regularParentPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 42,
                                  foregroundImage: NetworkImage(show != null
                                      ? show[1].profilePicture
                                      : "https://picsum.photos/400"),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: Dimen.regularParentPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        show != null ? show[1].fullName : "",
                                        style: kHeader2TextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: Dimen.regularParentPadding,
                            child: Column(
                              children: [
                                Text("About", style: kHeader4TextStyle),
                                Text(
                                    (show != null)
                                        ? show[1].biography
                                        : "Empty",
                                    style: kbody1TextStyle)
                              ],
                            ),
                          ),
                          Padding(
                            padding: Dimen.regularParentPaddingLR,
                            child: (widget.isPrivate && !isFollowed)
                                ? profileMainButtonRowPrivate(context)
                                : profileMainButtonRow(context),
                          ),
                          Padding(
                            padding: Dimen.regularPadding,
                            child: InkWell(
                              onTap: () async {
                                await changeFollowing();
                                setState(() {});
                              },
                              child: Container(
                                width: 128,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isFollowed == true
                                      ? AppColors.textColor
                                      : isWaiting == true
                                          ? AppColors.textColor
                                          : Colors.transparent,
                                  border: Border.all(
                                    color: isFollowed == true
                                        ? Colors.transparent
                                        : isWaiting == true
                                            ? Colors.transparent
                                            : AppColors.darkGrey,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                    isFollowed == true
                                        ? 'Following'
                                        : isWaiting == true
                                            ? "Request Sent"
                                            : 'Follow',
                                    style: TextStyle(
                                        color: isFollowed == true
                                            ? Colors.white
                                            : isWaiting == true
                                                ? Colors.white
                                                : AppColors.textColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                body: (isPrivate && !isFollowed)
                    ? const Icon(
                        IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                        size: 200,
                        color: AppColors.primary,
                      )
                    : Column(
                        children: [
                          TabBar(
                            controller: _controller,
                            tabs: const [
                              Tab(
                                  icon: Icon(Icons.photo_library_rounded,
                                      color: AppColors.primary)),
                              Tab(
                                  icon: Icon(Icons.text_snippet,
                                      color: AppColors.primary)),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _controller,
                              children: <Widget>[
                                GridView.builder(
                                  key: dataKey,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0,
                                  ),
                                  itemCount: miniPostList != null
                                      ? miniPostList.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        child: MiniPost(
                                            miniPostList != null
                                                ? miniPostList[index][1]
                                                    .pictureUrlArr[0]
                                                : "https://picsum.photos/600",
                                            isNetworkImg: miniPostList != null),
                                        onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SinglePost(
                                                            proUrl: show[1]
                                                                .profilePicture,
                                                            docId: miniPostList[
                                                                index][0],
                                                            name: show[1]
                                                                .fullName,
                                                            date: miniPostList[
                                                                    index][1]
                                                                .createdAt)),
                                              )
                                            });
                                  },
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: miniTextListJustPost == null
                                        ? []
                                            .map((e) => Card(
                                                child: Text(
                                                    "Nothing is shared yet")))
                                            .toList()
                                        : miniTextListJustPost.map((
                                            e,
                                          ) {
                                            idx += 1;
                                            return InkWell(
                                                onTap: () => {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => SinglePost(
                                                                proUrl: show[1]
                                                                    .profilePicture,
                                                                docId:
                                                                    miniTextList[
                                                                        idx][0],
                                                                name: show[1]
                                                                    .fullName,
                                                                date: e
                                                                    .createdAt)),
                                                      ),
                                                    },
                                                child: (PostView(
                                                  postModel: PostModel(
                                                    name: show != null
                                                        ? show[1].fullName
                                                        : "",
                                                    date: e.createdAt,
                                                    profileImg: show != null
                                                        ? show[1].profilePicture
                                                        : "https://picsum.photos/400",
                                                    likeCount: e.likeArr.length,
                                                    commentCount: 0,
                                                    contentCount: 0,
                                                    postText: e.postText,
                                                    contents: [],
                                                  ),
                                                )));
                                          }).toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        });
  }

  Row profileMainButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
              onPressed: () => {},
              child: ProfileCount("Moments", posts != null ? posts.length : 0)),
        ),
        Expanded(
            child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: Followers(
                        mylist: followers.followers,
                        refresher: () {
                          setState(() {});
                        }),
                    settings: const RouteSettings(name: Followers.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ProfileCount("Followers",
                    followers != null ? followers.followers.length : 0))),
        Expanded(
            child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: Following(
                        mylist: followings.followings,
                        refresher: () {
                          setState(() {});
                        }),
                    settings: const RouteSettings(name: Following.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ProfileCount("Following",
                    followings != null ? followings.followings.length : 0)))
      ],
    );
  }

  Row profileMainButtonRowPrivate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ProfileCount("Moments", posts != null ? posts.length : 0)),
        Expanded(
            child: ProfileCount("Followers",
                followers != null ? followers.followers.length : 0)),
        Expanded(
            child: ProfileCount("Following",
                followings != null ? followings.followings.length : 0))
      ],
    );
  }
}

class ProfileCount extends StatelessWidget {
  final String text;
  final int value;

  const ProfileCount(
    this.text,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Dimen.regularParentPadding,
        child: Column(
          children: [
            Text(
              value.toString(),
              style: kHeader3TextStyle,
            ),
            Text(
              text,
              style: kbody2TextStyle,
            )
          ],
        ),
      ),
    );
  }
}
