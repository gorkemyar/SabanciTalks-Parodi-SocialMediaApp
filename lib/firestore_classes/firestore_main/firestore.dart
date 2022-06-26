import 'dart:async';
import 'package:sabanci_talks/firestore_classes/comment/my_comment.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/firestore_classes/following/following.dart';
import 'package:sabanci_talks/firestore_classes/notifications/notification.dart';

import 'package:sabanci_talks/firestore_classes/requests/request.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Firestore {
  dynamic myData;

  late SharedPreferences prefs;
  String? uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  CollectionReference chat = FirebaseFirestore.instance.collection('chat');
  CollectionReference chatList =
      FirebaseFirestore.instance.collection('chatList');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comment');

  CollectionReference followerss =
      FirebaseFirestore.instance.collection('follower');
  CollectionReference followingss =
      FirebaseFirestore.instance.collection('following');
  CollectionReference requestss =
      FirebaseFirestore.instance.collection('request');
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        USER
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<String?> decideUser() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  Future<void> addUser(uid, fullName) async {
    myData = await users.add({
      "uid": uid,
      "fullName": fullName,
      "gender": "not selected",
      "private": false,
      "biography": "",
      "profilePicture":
          "https://www.innovaxn.eu/wp-content/uploads/blank-profile-picture-973460_1280.png",
      "postCount": 0,
      "following": 0,
      "follower": 0,
      "chatId": await createChatList(uid)
    });
  }

  Future<String> createChatList(uid) async {
    DocumentReference document = await chatList.add({
      "uid": uid,
      "chatList": [],
    });
    return document.id;
  }

  Future<List> getChatList(uid) async {
    QuerySnapshot querySnapshot =
        await chatList.where("uid", isEqualTo: uid).limit(1).get();
    return (querySnapshot.docs.first.data()! as Map)["chatList"];
  }

  Future<String> createChat(uid, otherUid) async {
    var data = await chatList.where("uid", isEqualTo: uid).limit(1).get();

    assert(data.docs.isNotEmpty);

    if (!((data.docs.first.data() as Map)["chatList"]
        .map((e) => e["uid"])
        .toList()
        .contains(otherUid))) {
      DocumentReference chatDoc = await chat.add({
        "messages": [],
      });

      chatList.doc(data.docs.first.id).update({
        "chatList": FieldValue.arrayUnion([
          {
            "chatId": chatDoc.id,
            "uid": otherUid,
          }
        ])
      });

      data = await chatList.where("uid", isEqualTo: otherUid).limit(1).get();

      chatList.doc(data.docs.first.id).update({
        "chatList": FieldValue.arrayUnion([
          {
            "chatId": chatDoc.id,
            "uid": uid,
          }
        ])
      });

      return chatDoc.id;
    } else {
      return (data.docs.first["chatList"] as List)
          .firstWhere((element) => element["uid"] == otherUid)["chatId"];
    }
  }

  Future<void> updateUser(
      docId, fullName, gender, biography, profilePicture) async {
    await users
        .doc(docId)
        .update({
          "fullName": fullName,
          "gender": gender,
          "biography": biography,
          "profilePicture": profilePicture,
        })
        .then((_) => print("success"))
        .catchError((error) => print('Failed: $error'));
  }

  Future<List<dynamic>?> getUser(uid) async {
    dynamic show;
    dynamic docId;
    myData = await users
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((doc) {
              show = [
                doc.id,
                MyUser.fromJson(doc.data() as Map<String, dynamic>)
              ];
            }).toList());
    return show;
  }

  Future<List<dynamic>?> searchUser(search) async {
    dynamic show;
    String searchLowercase = search.toLowerCase();
    List<String> searchList = [];
    myData = await users.get().then((value) => show = value.docs.map((doc) {
          MyUser temp = MyUser.fromJson(doc.data() as Map<String, dynamic>);
          String lowercaseName = temp.fullName.toLowerCase();

          if (lowercaseName.contains(searchLowercase)) {
            debugPrint("name of user is ${temp.fullName}");
            searchList.add(temp.uid);
          }
        }).toList());
    debugPrint("size of list is ${show.length}");
    return searchList;
  }

  Future<List<dynamic>> explorePage() async {
    dynamic show;
    dynamic temp;
    List<String> userList = [];
    myData = await users.get().then((value) => show = value.docs.map((doc) {
          MyUser temp = MyUser.fromJson(doc.data() as Map<String, dynamic>);
          if (!temp.private) {
            userList.add(temp.uid);
          }
        }).toList());
    List<dynamic> postList = [];

    temp = await posts.get().then((value) => show = value.docs.map((e) {
          MyPost post = MyPost.fromJson(e.data() as Map<String, dynamic>);
          if (userList.contains(post.uid) && post.pictureUrlArr.isNotEmpty) {
            postList.add([e.id, post]);
          }
        }).toList());
    return postList;
  }

  Future<void> changePrivacy(docId, privacy) async {
    await users
        .doc(docId)
        .update({"private": privacy})
        .then((_) => print("success"))
        .catchError((error) => print('Failed: $error'));
  }

  //needs to be implemented
  //update privacy
  //delete user

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        follower-following-request
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Getter functions for follower-following-request
  Future<dynamic> getFollowers(uid) async {
    dynamic follower;
    myData = await followerss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        follower = Follower.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    return follower;
  }

  Future<dynamic> getFollowings(uid) async {
    dynamic following;
    myData = await followingss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        following = Following.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    return following;
  }

  Future<dynamic> getRequestss(uid) async {
    dynamic request;
    myData = await requestss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        request = Request.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    return request;
  }

  // checker functions for follower-following-request
  Future<bool> isPrivate(uid) async {
    dynamic isPrivate;
    await getUser(uid)
        .then((value) => isPrivate = value != null ? value[1].private : true);
    return isPrivate;
  }

  //Is uid followed  followuid?
  Future<bool> isFollowed(uid, followUid) async {
    dynamic result = false;
    dynamic followingList = await getFollowings(uid).then((value) => {
          for (int i = 0; i < value.followings.length; i++)
            {
              if (value.followings[i] == followUid) {result = true}
            }
        });

    debugPrint("bunu da dene is ${result}");
    return result;
  }

  Future<bool> isRequested(uid, followUid) async {
    dynamic result = false;
    dynamic requestList = await getRequestss(uid).then((value) => {
          for (int i = 0; i < value.requests.length; i++)
            {
              if (value.requests[i] == followUid) {result = true}
            }
        });

    debugPrint("bunu da dene is ${result}");
    return result;
  }

  Future<bool> isReqandFollow(uid, followUid) async {
    dynamic isreq = await isRequested(uid, followUid);
    dynamic isfol = await isFollowed(uid, followUid);
    return !(await isreq && await isfol);
  }

  //Find docId functions for follower-following-request
  Future<dynamic> findFollowerDocId(uid) async {
    dynamic docId;
    myData = await followerss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  Future<dynamic> findFollowingDocId(uid) async {
    dynamic docId;
    myData = await followingss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  Future<dynamic> findRequestsDocId(uid) async {
    dynamic docId;
    myData = await requestss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  //Adder functions for follower-following-request

  // add followUid to follower list of uid
  Future<void> addFollow(uid, followUid) async {
    dynamic docId = await findFollowerDocId(uid);
    followerss.doc(docId).update({
      "followers": FieldValue.arrayUnion([followUid])
    });
    return;
  }

  // add followingUid to following list of uid
  Future<void> addFollowing(uid, followingUid) async {
    dynamic docId = await findFollowingDocId(uid);
    followingss.doc(docId).update({
      "followings": FieldValue.arrayUnion([followingUid])
    });
    return;
  }

  // add requesUid to request list of uid
  Future<void> addRequest(uid, requestId) async {
    dynamic docId = await findRequestsDocId(uid);
    requestss.doc(docId).update({
      "requests": FieldValue.arrayUnion([requestId])
    });
    return;
  }

  //Delete functions for follower-following-request

  //uid unfollowed by followuid
  Future<void> unFollow(uid, followUid) async {
    dynamic docId = await findFollowerDocId(uid);
    followerss.doc(docId).update({
      "followers": FieldValue.arrayRemove([followUid])
    });
    return;
  }

  // uid unfollowed followinguid
  Future<void> deleteFollowing(uid, followingUid) async {
    dynamic docId = await findFollowingDocId(uid);
    followingss.doc(docId).update({
      "followings": FieldValue.arrayRemove([followingUid])
    });
    return;
  }

  // uid delete requestId
  Future<void> deleteRequest(uid, requestId) async {
    dynamic docId = await findRequestsDocId(uid);
    requestss.doc(docId).update({
      "requests": FieldValue.arrayRemove([requestId])
    });
    return;
  }

  // Create functions for follower-following-request

  Future<void> createFollowers(uid) async {
    myData = await followerss.add({"uid": uid, "followers": []});
  }

  Future<void> createFollowing(uid) async {
    myData = await followingss.add({"uid": uid, "followings": []});
  }

  Future<void> createRequests(uid) async {
    myData = await requestss.add({"uid": uid, "requests": []});
  }

  //Accept and Reject request

  Future<void> acceptRequest(uid, requestUid) async {
    await deleteRequest(uid, requestUid);
    await addFollow(uid, requestUid);
    await addFollowing(requestUid, uid);
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        Notifications
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<dynamic>?> getNotification(uid) async {
    dynamic myNotifications;
    myData =
        await notifications.where("uid", isEqualTo: uid).get().then((value) {
      myNotifications = value.docs.map((doc) {
        return Notifications.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return myNotifications;
  }

  Future<void> addNotification(
      {required uid,
      required notification_type,
      required uid_sub,
      required isPost,
      required postId}) async {
    myData = await notifications.add({
      "uid": uid,
      "notification_type": notification_type,
      "uid_sub": uid_sub,
      "isPost": isPost,
      "postId": postId,
    });
    return;
  }

  Future<void> deleteNotification(uid, uid_sub) async {
    debugPrint("helllloooo are you there");
    dynamic docId;
    myData =
        await notifications.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        dynamic temp =
            Notifications.fromJson(doc.data() as Map<String, dynamic>);

        if (temp.uid_sub == uid_sub) {
          notifications.doc(doc.id).delete();
        }
      }).toList();
    });
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        POSTS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<MyPost?> getSpecificPost(documentId) async {
    dynamic posts2;
    myData = await posts.doc(documentId).get().then((value) =>
        {posts2 = MyPost.fromJson(value.data() as Map<String, dynamic>)});
    debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }

  Future<List<dynamic>> getFeedPostsByLimit(int limit,
      {bool onlyFollowed = false}) async {
    dynamic postsJSON;

    if (onlyFollowed) {
      final myUid = await decideUser();
      dynamic followings = await getFollowings(myUid);
      // get the followings list of uids
      if (followings != null) {
        List<dynamic> followingsUids = followings.followings;
        followingsUids.add(myUid);
        if (followingsUids.isNotEmpty) {
          // get the posts of the followings
          debugPrint("followings $followings");
          myData = await posts
              .where("uid", whereIn: followingsUids)
              .orderBy("createdAt", descending: true)
              .limit(limit)
              .get()
              .then((value) {
            postsJSON = value.docs.map((doc) {
              return [
                doc.id,
                MyPost.fromJson(doc.data() as Map<String, dynamic>)
              ];
            }).toList();
          });
          //debugPrint("Post is ${posts2.toString()}");
          return postsJSON;
        } else {
          List<dynamic> emptyList = [];
          return emptyList;
        }
      } else {
        List<dynamic> emptyList = [];
        return emptyList;
      }
    } else {
      myData = await posts
          .orderBy("createdAt", descending: true)
          .limit(limit)
          .get()
          .then((value) {
        postsJSON = value.docs.map((doc) {
          return [doc.id, MyPost.fromJson(doc.data() as Map<String, dynamic>)];
        }).toList();
      });
      //debugPrint("Post is ${posts2.toString()}");
      return postsJSON;
    }
  }

  Future<List<dynamic>?> getPost(uid) async {
    debugPrint("uid: ${uid}");
    dynamic posts2;
    myData = await posts.where("uid", isEqualTo: uid).get().then((value) {
      posts2 = value.docs.map((doc) {
        return [doc.id, MyPost.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }

  Future<void> addPost(
      {required uid,
      required createdAt,
      required urlArr,
      required postText}) async {
    myData = await posts.add({
      "uid": uid,
      "createdAt": createdAt,
      "postText": postText,
      "pictureUrlArr": urlArr,
      "likeArr": []
    });
    return;
  }

  Future<void> updatePost(
      {required docId,
      required uid,
      required createdAt,
      required postText,
      required pictureUrlArr,
      required likeArr}) async {
    await posts
        .doc(docId)
        .update({
          "uid": uid,
          "createdAt": createdAt,
          "postText": postText,
          "pictureUrlArr": pictureUrlArr,
          "likeArr": likeArr,
        })
        .then((_) => print("success"))
        .catchError((error) => print('Failed: $error'));
  }

  Future<void> deletePost(docId) async {
    await posts.doc(docId).delete().then(
          (doc) => print("Post deleted"),
          onError: (e) => print("Error deleting post $e"),
        );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        Comments
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> addComment(
      {required postid, required uid, required commentText}) async {
    myData = await comment
        .add({"postid": postid, "uid": uid, "comment": commentText});
    return;
  }

  Future<List<dynamic>> getAllComments(postid) async {
    debugPrint("postid: ${postid}");
    dynamic result;
    myData =
        await comment.where("postid", isEqualTo: postid).get().then((value) {
      result = value.docs.map((doc) {
        return [doc.id, MyComment.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    if (result != null) {
      return result;
    } else {
      List<dynamic> emptyList = [];
      return emptyList;
    }
  }
}
