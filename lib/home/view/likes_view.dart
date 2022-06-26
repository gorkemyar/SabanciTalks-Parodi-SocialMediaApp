import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/widgets/person_header_widget.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  static const String routeName = '/likes';

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Likes'),
        ),
        body: _body());
  }

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          itemBuilder: (context, index) => PersonHeaderWidget(
            element: MyUser(uid: "2"),
            refresher: () {
              setState(() {});
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemCount: 12,
        ),
      );
}
