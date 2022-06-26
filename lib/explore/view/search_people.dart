import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/widgets/person_header_widget.dart';

class SearchPeople extends StatelessWidget {
  SearchPeople({Key? key, required this.mylist, required this.refresher})
      : super(key: key);
  dynamic mylist;
  VoidCallback refresher;
  static const String routeName = '/searchPeople';

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              refresher;
              Navigator.of(context).pop();
            }),
            title: const Text('Search People'),
          ),
          body: SizedBox(
            width: double.infinity,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4),
              shrinkWrap: true,
              itemBuilder: (context, index) => PersonHeaderWidget(
                  element: mylist[index], refresher: refresher),
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              itemCount: mylist != null ? mylist.length : 0,
            ),
          ));
    });
  }
}
