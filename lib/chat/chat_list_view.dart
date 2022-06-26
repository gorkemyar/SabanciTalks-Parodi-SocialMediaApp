import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListModel {
  MyUser user;
  String docId;

  ChatListModel({required this.user, required this.docId});
}

class ChatList extends StatefulWidget {
  ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final List<ChatListModel> _users = [];
  Firestore firestore = Firestore();

  Future<bool> _loadUsers() async {
    _users.clear();
    var pref = await SharedPreferences.getInstance();
    String? uid = pref.getString("user");
    if (uid != null) {
      List data = await firestore.getChatList(uid);
      for (int i = 0; i < data.length; i++) {
        List? _user = await firestore.getUser(data[i]["uid"]);
        if (_user != null) {
          _users.add(ChatListModel(user: _user[1], docId: data[i]["chatId"]));
        }
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat List'), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => NavigationService.instance
              .navigateToPage(path: NavigationConstants.NEW_CHAT),
        ),
      ]),
      body: _body(),
    );
  }

  FutureBuilder _body() {
    return FutureBuilder(
      future: _loadUsers(),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4),
              shrinkWrap: true,
              itemBuilder: (context, index) => ChatListItem(
                model: _users[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              itemCount: _users.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final ChatListModel model;
  const ChatListItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.CHAT, data: model.docId);
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            model.user.profilePicture,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(model.user.fullName),
      ),
    );
  }
}
