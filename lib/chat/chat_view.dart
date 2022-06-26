import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatView extends StatefulWidget {
  final String chatId;
  ChatView({Key? key, required this.chatId}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Firestore firestore = Firestore();
  List<types.Message> _messages = [];
  late types.User _user;
  _loadMessages() {
    final docRef = firestore.chat.doc(widget.chatId);
    docRef.snapshots().listen((event) {
      setState(() {
        print(event.data());
        _messages = ((event.data() as Map)["messages"] as List)
            .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    });
  }

  void _addMessage(types.Message message) {
    _messages.add(message);
    firestore.chat.doc(widget.chatId).update(
      {
        "messages": FieldValue.arrayUnion([message.toJson()]),
      },
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  Future<bool> initChat() async {
    var pref = await SharedPreferences.getInstance();
    String uid = pref.getString("user") ?? "";
    List? user = await firestore.getUser(uid);
    _loadMessages();
    if (user != null) {
      _user = types.User(
        id: uid,
        imageUrl: user[1].profilePicture,
        firstName: user[1].fullName,
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: FutureBuilder(
          future: initChat(),
          builder: (context, snapshot) =>
              snapshot.hasData && snapshot.data as bool
                  ? Chat(
                    
                      messages: _messages.reversed.toList(),
                      onSendPressed: _handleSendPressed,
                      user: _user,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
    );
  }
}
