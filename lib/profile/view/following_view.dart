import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/widgets/person_header_widget.dart';

class Following extends StatelessWidget {
  Following({Key? key, required this.mylist, required this.refresher})
      : super(key: key);
  dynamic mylist;
  VoidCallback refresher;

  static const String routeName = '/followers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Following'),
          leading: BackButton(onPressed: () {
            refresher;
            Navigator.of(context).pop();
          }),
        ),
        body: _body());
  }

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              PersonHeaderWidget(element: mylist[index], refresher: refresher),
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemCount: mylist != null ? mylist.length : 0,
        ),
      );
}
