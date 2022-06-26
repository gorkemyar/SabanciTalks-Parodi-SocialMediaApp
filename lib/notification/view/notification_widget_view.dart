import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/userProfile/userProfile.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';

class NotificationWidget extends StatefulWidget {
  NotificationWidget(
      {Key? key, required this.notification, required this.refreshFunction})
      : super(key: key);
  dynamic notification;
  VoidCallback refreshFunction;
  @override
  State<NotificationWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  int index = 0;
  Firestore f = Firestore();
  bool isFollowed = false;
  String type = "like";
  bool isFollow = true;

  @override
  void initState() {
    super.initState();
    //debugPrint("notification widget ${widget.notification.toString()}");
  }

  dynamic comingUser;
  dynamic meUser;
  dynamic post;
  dynamic isFollowing;
  dynamic isPriv;
  Future<void> findNotification() async {
    Firestore f = Firestore();
    comingUser = await f.getUser(widget.notification.uid_sub);
    meUser = await f.getUser(widget.notification.uid);
    if (widget.notification.isPost == true) {
      post = await f.getSpecificPost(widget.notification.postId);
    }
    isFollowing = await f.isFollowed(
      widget.notification.uid_sub,
      widget.notification.uid,
    );
    isPriv = await f.isPrivate(widget.notification.uid_sub);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future(() {
          setState(() {});
        });
      },
      child: FutureBuilder(
          future: findNotification(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.notification.notification_type == "like" ||
                        widget.notification.notification_type == "comment"
                    ? _like(
                        comingUser != null ? comingUser[1].fullName : "",
                        widget.notification.notification_type,
                        comingUser != null
                            ? comingUser[1].profilePicture
                            : "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                        post != null && post.pictureUrlArr.length != 0
                            ? post.pictureUrlArr[0]
                            : "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg")
                    : widget.notification.notification_type == "follow"
                        ? _follow(
                            comingUser != null ? comingUser[1].fullName : "",
                            comingUser != null
                                ? comingUser[1].profilePicture
                                : "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            meUser != null
                                ? meUser[1].profilePicture
                                : "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                          )
                        : _wannafollow(
                            comingUser != null ? comingUser[1].fullName : "",
                            comingUser != null
                                ? comingUser[1].profilePicture
                                : "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                          ),

                //_comment("Charles_Leclers"),
                //_wannafollow("Gorkem Yar")
              ],
            );
          }),
    );
  }

  ListTile _header() {
    return const ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(
            'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
      ),
      title: Text("Charles Leclers"),
      subtitle: Text("@Charles_Leclerc"),
    );
  }

  Padding _like(person, type, userImageUrl, postImageUrl) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            CircleAvatar(
              radius: 24,
              foregroundImage: NetworkImage(userImageUrl),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: RichText(
                text: TextSpan(
                  text: person,
                  style: notificationBegin,
                  children: [
                    TextSpan(
                      text: type == "like"
                          ? " is liked your photo."
                          : type == "comment"
                              ? " commented on your photo."
                              : " tagged you.",
                      style:
                          notificationEnd!.copyWith(color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
            Image.network(
              postImageUrl,
              width: 50,
              height: 50,
            ),
          ]),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
            color: AppColors.primary,
          ),
        ],
      ));

  Padding _follow(person, imageUrlUser, imageUrlMe) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            IconButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: UserProfileView(
                    uid: widget.notification.uid_sub,
                    isPrivate: isPriv == true,
                    isFollowed: isFollowing == true,
                    refresher: () {
                      setState(() {});
                    },
                  ),
                  settings: RouteSettings(name: UserProfileView.routeName),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: CircleAvatar(
                foregroundImage: NetworkImage(imageUrlUser),
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: UserProfileView(
                      uid: widget.notification.uid_sub,
                      isPrivate: isPriv == true,
                      isFollowed: isFollowing == true,
                      refresher: () {
                        setState(() {});
                      },
                    ),
                    settings: RouteSettings(name: UserProfileView.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: person,
                    style: commentBegin,
                    children: [
                      TextSpan(
                        text: " followed you.",
                        style: commentEnd!.copyWith(color: AppColors.darkGrey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            CircleAvatar(
              foregroundImage: NetworkImage(imageUrlMe),
            ),
            const Spacer(flex: 1),
          ]),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
            color: AppColors.primary,
          ),
        ],
      ));
  Padding _wannafollow(
    person,
    imageUrlUser,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: UserProfileView(
                      uid: widget.notification.uid_sub,
                      isPrivate: isPriv == true,
                      isFollowed: isFollowing == true,
                      refresher: () {
                        setState(() {});
                      },
                    ),
                    settings: RouteSettings(name: UserProfileView.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: CircleAvatar(
                  foregroundImage: NetworkImage(imageUrlUser),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: TextButton(
                  onPressed: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: UserProfileView(
                        uid: widget.notification.uid_sub,
                        isPrivate: isPriv == true,
                        isFollowed: isFollowing == true,
                        refresher: () {
                          setState(() {});
                        },
                      ),
                      settings: RouteSettings(name: UserProfileView.routeName),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: person,
                      style: commentBegin,
                      children: [
                        TextSpan(
                          text: " want to follow you.",
                          style:
                              commentEnd!.copyWith(color: AppColors.darkGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              IconButton(
                  onPressed: () async {
                    await f.acceptRequest(
                        widget.notification.uid, widget.notification.uid_sub);
                    await f.deleteNotification(
                        widget.notification.uid, widget.notification.uid_sub);
                    await f.addNotification(
                        uid: widget.notification.uid,
                        notification_type: "follow",
                        uid_sub: widget.notification.uid_sub,
                        isPost: false,
                        postId: "");
                    widget.refreshFunction();
                  },
                  icon: const Icon(
                      IconData(0xef49, fontFamily: 'MaterialIcons'))),
              IconButton(
                  onPressed: () async {
                    await f.deleteRequest(
                        widget.notification.uid, widget.notification.uid_sub);

                    await f.deleteNotification(
                        widget.notification.uid, widget.notification.uid_sub);
                    widget.refreshFunction();
                  },
                  icon: const Icon(
                      IconData(0xef58, fontFamily: 'MaterialIcons'))),
            ]),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 0.1,
              color: AppColors.primary,
            ),
          ],
        ),
      );
}
