import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/home/view/comment_view.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/post/functions/post_functions.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostHeroModel {
  int? likeCount;
  int? commentCount;
  int? contentCount;
  int? index;
  List<String>? imgUrls;
  bool? isLiked;

  PostHeroModel({
    this.likeCount,
    this.commentCount,
    this.contentCount,
    this.imgUrls,
    this.index,
    this.isLiked = false,
  });
}

class PostView extends StatefulWidget {
  final PostModel postModel;
  const PostView({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool isSaved = false;
  MyPost? myPost;
  List<String> likeArrCopy = [];

  changeLike() async {
    var prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("user") ?? "";
    Firestore f = Firestore();
    myPost = await f.getSpecificPost(widget.postModel.postId);
    likeArrCopy = [];

    if (myPost != null ? myPost!.likeArr.isNotEmpty : false) {
      for (String user in myPost!.likeArr) {
        likeArrCopy.add(user);
      }
    }

    debugPrint("mypost $myPost");

    // If uid is in the likeArr remove it and set isLiked false
    // else add uid to the likeArr and set isLiked true
    if (uid != "") {
      if (likeArrCopy.contains(uid)) {
        // user liked the picture before
        likeArrCopy.remove(uid);
        await f.updatePost(
            docId: widget.postModel.postId,
            uid: myPost?.uid,
            createdAt: myPost?.createdAt,
            postText: myPost?.postText,
            pictureUrlArr: myPost?.pictureUrlArr,
            likeArr: likeArrCopy);
        widget.postModel.isLiked = false;
      } else {
        // user did not like the picture before
        likeArrCopy.add(uid);
        await f.updatePost(
            docId: widget.postModel.postId,
            uid: myPost?.uid,
            createdAt: myPost?.createdAt,
            postText: myPost?.postText,
            pictureUrlArr: myPost?.pictureUrlArr,
            likeArr: likeArrCopy);
        widget.postModel.isLiked = true;
        await f.addNotification(
            uid: myPost?.uid,
            notification_type: "like",
            uid_sub: uid,
            isPost: true,
            postId: widget.postModel.postId);
      }
    }
    setState(() {
      //widget.postModel.isLiked = widget.postModel.isLiked!;
      widget.postModel.likeCount = likeArrCopy.length;
    });
  }

  openPostHero({
    required PostModel post,
    required int index,
  }) {
    List<String> imgUrls = post.contents!.map((e) => e.source!).toList();
    PostHeroModel postHero = PostHeroModel(
        likeCount: post.likeCount,
        commentCount: post.commentCount,
        contentCount: post.contentCount,
        imgUrls: imgUrls,
        index: index,
        isLiked: post.isLiked);
    NavigationService.instance
        .navigateToPage(path: NavigationConstants.SINGLE_POST, data: postHero);
  }

  changeSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0x19575B7D),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ), //padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _listTile(),
            _postText(),
            _contentContainer(),
            _buttons(),
          ],
        ),
      ),
    );
  }

  ListTile _listTile() {
    return ListTile(
      leading: _profilePicture(),
      title: _title(),
      subtitle: _subtitle(),
    );
  }

  CachedNetworkImage _profilePicture() {
    return CachedNetworkImage(
      width: 44,
      height: 44,
      imageUrl: widget.postModel.profileImg!,
      imageBuilder: (context, imageProvider) => Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Text _title() => Text(
        widget.postModel.name!,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF161F3D),
        ),
      );

  Text _subtitle() => Text(widget.postModel.date!);

  Padding _postText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(78, 0, 24, 12),
      child: Text(
        widget.postModel.postText!,
        style: const TextStyle(
          fontSize: 13,
          height: 1.25,
          color: Color(0xFF161F3D),
        ),
      ),
    );
  }

  Padding _buttons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          children: [
            IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                widget.postModel.isLiked!
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
              ),
              color: widget.postModel.isLiked!
                  ? AppColors.secondary
                  : AppColors.darkGrey,
              iconSize: 18,
              onPressed: () => changeLike(),
            ),
            InkWell(
                onTap: () => {},
                child: Container(
                  child: _integrationCount(
                      convertCount(widget.postModel.likeCount!)),
                ))
          ],
        ),
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
              constraints: const BoxConstraints(),
              icon: const Icon(CupertinoIcons.bubble_left),
              color: AppColors.darkGrey,
              iconSize: 18,
              onPressed: () async {
                debugPrint("uid is ${widget.postModel.uid}");
                if (widget.postModel.postId != null &&
                    widget.postModel.uid != null) {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: Comments(
                        postId: widget.postModel.postId!,
                        postOwnerId: widget.postModel.uid!),
                    settings: const RouteSettings(name: Comments.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }
              },
            ),
          ],
        ),
      ]),
    );
  }

  SizedBox _integrationCount(String count) => SizedBox(
        width: 36.5,
        child: Text(
          count,
          style: const TextStyle(color: AppColors.darkGrey, fontSize: 12),
        ),
      );

  Padding _contentContainer() {
    if (widget.postModel.contentCount! > 0) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(78, 0, 24, 0),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD8D8D8)),
                borderRadius: BorderRadius.circular(9),
              ),
              child: _setContent()));
    } else {
      return const Padding(padding: EdgeInsets.zero);
    }
  }

  Widget _setContent() {
    int _contentCount = widget.postModel.contentCount!;
    if (_contentCount == 1) {
      return _oneContent();
    } else if (_contentCount == 2) {
      return _twoContent();
    } else if (_contentCount == 3) {
      return _threeContent();
    } else if (_contentCount == 4) {
      return _fourContent();
    }
    return _oneContent();
  }

  ClipRRect _oneContent() => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          child: CachedNetworkImage(
            width: 290,
            fit: BoxFit.contain,
            imageUrl: widget.postModel.contents![0].source!,
          ),
          onTap: () {
            openPostHero(
              post: widget.postModel,
              index: 0,
            );
          },
        ),
      );

  Row _twoContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: InkWell(
              child: CachedNetworkImage(
                width: 130,
                height: 173.5,
                fit: BoxFit.fill,
                imageUrl: widget.postModel.contents![0].source!,
              ),
              onTap: () {
                openPostHero(
                  post: widget.postModel,
                  index: 0,
                );
              },
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: InkWell(
              child: CachedNetworkImage(
                width: 130,
                height: 173.5,
                fit: BoxFit.fill,
                imageUrl: widget.postModel.contents![1].source!,
              ),
              onTap: () {
                openPostHero(
                  post: widget.postModel,
                  index: 1,
                );
              },
            ),
          )
        ],
      );

  Row _threeContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: InkWell(
              child: CachedNetworkImage(
                width: 130,
                height: 173.5,
                fit: BoxFit.cover,
                imageUrl: widget.postModel.contents![0].source!,
              ),
              onTap: () {
                openPostHero(
                  post: widget.postModel,
                  index: 0,
                );
              },
            ),
          ),
          SizedBox(
            height: 173.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![1].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 1,
                      );
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![2].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Row _fourContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 173.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![0].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 0,
                      );
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![2].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 173.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![1].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 1,
                      );
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  child: InkWell(
                    child: CachedNetworkImage(
                      width: 130,
                      height: 85.5,
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.contents![3].source!,
                    ),
                    onTap: () {
                      openPostHero(
                        post: widget.postModel,
                        index: 3,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
