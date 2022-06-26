import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';

//import 'package:sabanci_talks/firestore_classes/user/user.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/post/view/single_post.dart';

import 'package:sabanci_talks/profile/view/edit_profile.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/settings/view/settings_view.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';
import '../../post/model/post_model.dart';
import '../../post/view/post_view.dart';
import "package:sabanci_talks/firestore_classes/firestore_main/firestore.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  final dataKey = GlobalKey();
  dynamic myUser;
  MyUser? myUserFromJson;
  String? uid;
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
  Future<void> getUser() async {
    idx = -1;
    miniPostListJustPost = [];
    miniTextListJustPost = [];
    uid = await f.decideUser();
    show = await f.getUser(uid);
    posts = await f.getPost(uid);
    followers = await f.getFollowers(uid);
    followings = await f.getFollowings(uid);
    debugPrint("uid is ${uid}");
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

    //debugPrint("followers is now ${followers.toString()}");
    //debugPrint("show is ${show.toString()}");
  }

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  Row _settingsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: EditProfileView(
                  docId: show != null ? show[0] : "",
                  genderPre: show != null ? show[1].gender : "",
                  fullNamePre: show != null ? show[1].fullName : "",
                  biographyPre: show != null ? show[1].biography : "",
                  picturePre: show != null
                      ? show[1].profilePicture
                      : "https://picsum.photos/400",
                ),
                settings: const RouteSettings(name: EditProfileView.routeName),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: Settings2(
                  docId: show != null ? show[0] : "",
                  isPrivate: show != null ? show[1].private : false,
                ),
                settings: const RouteSettings(name: Settings2.routeName),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Profile View");

    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          _settingsRow(),
                          Padding(
                            padding: Dimen.regularParentPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await _showProfilePicture(
                                        show != null ? show[1].fullName : "",
                                        show != null
                                            ? show[1].profilePicture
                                            : "https://picsum.photos/400",
                                        true);
                                  },
                                  iconSize: 100,
                                  icon: CircleAvatar(
                                    radius: 42,
                                    foregroundImage: NetworkImage(show != null
                                        ? show[1].profilePicture
                                        : "https://picsum.photos/400"),
                                  ),
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
                            child: profileMainButtonRow(context),
                          ),
                        ]),
                      ),
                    ]),
                body: Column(
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
                            itemCount:
                                miniPostList != null ? miniPostList.length : 0,
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
                                              builder: (context) => SinglePost(
                                                  proUrl:
                                                      show[1].profilePicture,
                                                  docId: miniPostList[index][0],
                                                  name: show[1].fullName,
                                                  date: miniPostList[index][1]
                                                  
                                                      .createdAt)),
                                        )
                                      });
                            },
                          ),
                          ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: miniTextListJustPost == null
                                  ? []
                                      .map((e) => Card(
                                          child: Text("Nothing is shared yet")))
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
                                                      builder: (context) =>
                                                          SinglePost(
                                                              proUrl: show[1]
                                                                  .profilePicture,
                                                              docId:
                                                                  miniTextList[
                                                                      idx][0],
                                                              name: show[1]
                                                                  .fullName,
                                                              date:
                                                                  e.createdAt)),
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

  Future<void> _showProfilePicture(
      String title, dynamic image, bool isNetwork) async {
    bool isAndroid = Platform.isAndroid;

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            debugPrint("hello is exploded");
            return AlertDialog(
              title: Center(child: Text(title)),
              content: MiniPost(
                image,
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: kBoldLabelStyle),
              content: MiniPost(
                image,
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
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
