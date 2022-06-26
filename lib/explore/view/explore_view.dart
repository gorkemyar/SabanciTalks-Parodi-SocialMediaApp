import 'package:flutter/material.dart';
import 'package:sabanci_talks/explore/view/search_people.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/post/view/single_post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/analytics.dart';

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}

// Search Page
class ExploreView extends StatefulWidget {
  ExploreView({Key? key}) : super(key: key);
  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  List<dynamic> postList = [];
  Firestore f = Firestore();
  Future<void> _getPosts() async {
    postList = await f.explorePage();
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Explore Page");
    debugPrint("length is ${postList.length}");
    return FutureBuilder(
        future: _getPosts(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
                // The search area here
                title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onSubmitted: (String value) async {
                    debugPrint("search is ${value}");
                    Firestore f = Firestore();
                    dynamic userList = await f.searchUser(value);
                    debugPrint("userlist is ${userList}");
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPeople(
                                  mylist: userList,
                                  refresher: () {
                                    setState(() {});
                                  },
                                )));
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.clear),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 3,
              ),
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(postList[index][1].pictureUrlArr[0]),
                        ),
                      ),
                    ),
                    onTap: () async {
                      dynamic postUser =
                          await f.getUser(postList[index][1].uid);

                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SinglePost(
                                    docId: postList[index][0],
                                    proUrl: postUser != null
                                        ? postUser[1].profilePicture
                                        : "https://picsum.photos/400",
                                    name: postUser != null
                                        ? postUser[1].fullName
                                        : "",
                                    date: postList[index][1].createdAt,
                                  )));
                    });
              },
            ),
          );
        });
  }
}
