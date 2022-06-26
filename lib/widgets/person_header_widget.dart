import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/userProfile/userProfile.dart';
import 'package:sabanci_talks/util/colors.dart';

class PersonHeaderWidget extends StatefulWidget {
  PersonHeaderWidget({Key? key, required this.element, required this.refresher})
      : super(key: key);
  VoidCallback refresher;
  dynamic element;
  @override
  State<PersonHeaderWidget> createState() => _PersonHeaderWidgetState();
}

class _PersonHeaderWidgetState extends State<PersonHeaderWidget> {
  dynamic isFollowing = false;
  dynamic uid;
  dynamic user;
  Firestore f = Firestore();
  dynamic isWaiting = false;
  Future<void> userList() async {
    isPriv = await f.isPrivate(widget.element);
    uid = await f.decideUser();
    user = await f.getUser(widget.element);
    //debugPrint("userrrr ${user.toString()}");
    isFollowing = await f.isFollowed(uid, widget.element);
    isWaiting = await f.isRequested(widget.element, uid);
  }

  dynamic isPriv;
  changeFollowing(refresher) async {
    if (isFollowing == true) {
      await f.unFollow(widget.element, uid);
      await f.deleteFollowing(uid, widget.element);
    } else {
      if (isPriv == true) {
        await f.addRequest(widget.element, uid);
        await f.addNotification(
            uid: widget.element,
            notification_type: "request",
            uid_sub: uid,
            isPost: false,
            postId: "");
      } else {
        await f.addFollow(widget.element, uid);
        await f.addFollowing(uid, widget.element);
        await f.addNotification(
            uid: widget.element,
            notification_type: "follow",
            uid_sub: uid,
            isPost: false,
            postId: "");
      }
    }
    setState(() {
      if (isFollowing == true) {
        //f.deleteFollowing(widget.element, uid);
        isFollowing = false;
      } else {
        if (isPriv == true) {
          isWaiting = true;
        } else {
          isFollowing == true;
        }
      }
    });
    refresher();
    userList();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("helllooooo ${isFollowing != null ? isFollowing == true : -1}");
    return FutureBuilder(
        future: userList(),
        builder: (context, snapshot) {
          return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: IconButton(
                  icon: Image.network(
                    user != null
                        ? user[1].profilePicture
                        : "https://picsum.photos/600",
                  ),
                  onPressed: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: UserProfileView(
                        uid: widget.element,
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
                ),
              ),
              title: TextButton(
                child: Text(user != null ? user[1].fullName : ""),
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: UserProfileView(
                      uid: widget.element,
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
              ),
              //subtitle: const Text('@Carlossainz55'),
              trailing: InkWell(
                onTap: () => changeFollowing(widget.refresher),
                child: Container(
                  width: 128,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isFollowing == true
                        ? AppColors.textColor
                        : isWaiting == true
                            ? AppColors.textColor
                            : Colors.transparent,
                    border: Border.all(
                      color: isFollowing == true
                          ? Colors.transparent
                          : isWaiting == true
                              ? Colors.transparent
                              : AppColors.darkGrey,
                      width: 1,
                    ),
                  ),
                  child: Text(
                      isFollowing == true
                          ? 'Following'
                          : isWaiting == true
                              ? "Request Sent"
                              : 'Follow',
                      style: TextStyle(
                          color: isFollowing == true
                              ? Colors.white
                              : isWaiting == true
                                  ? Colors.white
                                  : AppColors.textColor,
                          fontWeight: FontWeight.w500)),
                ),
              ));
        });
  }
}
