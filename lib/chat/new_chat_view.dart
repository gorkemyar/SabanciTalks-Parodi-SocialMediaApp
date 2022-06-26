import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/following/following.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewChatView extends StatefulWidget {
  const NewChatView({Key? key}) : super(key: key);

  @override
  State<NewChatView> createState() => _NewChatViewState();
}

class _NewChatViewState extends State<NewChatView> {
  final List<MyUser> _users = [];
  String? uid;
  Firestore firestore = Firestore();

  Future<bool> _loadFollowings() async {
    _users.clear();
    var pref = await SharedPreferences.getInstance();
    uid = pref.getString("user");
    if (uid != null) {
      Following data = await firestore.getFollowings(uid);
      for (int i = 0; i < data.followings.length; i++) {
        List? _user = await firestore.getUser(data.followings[i]);
        if (_user != null) {
          _users.add(_user[1]);
        }
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
      ),
      body: _body(),
    );
  }

  FutureBuilder _body() => FutureBuilder(
        future: _loadFollowings(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: (() async {
                    print(uid);
                    String docId =
                        await firestore.createChat(uid, _users[index].uid);
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstants.CHAT, data: docId);
                  }),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        _users[index].profilePicture,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _users[index].fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: _users.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
}
