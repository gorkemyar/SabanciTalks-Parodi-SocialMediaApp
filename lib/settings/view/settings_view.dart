import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/sign_in/view/reset_password_view.dart';
import 'package:sabanci_talks/sign_in/view/verification.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/welcome/view/goodby_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings2 extends StatefulWidget {
  const Settings2({Key? key, required this.docId, required this.isPrivate})
      : super(key: key);
  final String docId;
  final bool isPrivate;
  static const String routeName = '/settings';

  @override
  State<Settings2> createState() => _Settings2State();
}

class _Settings2State extends State<Settings2> {
  final Authentication _auth = Authentication();

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: _body());
  }

  SingleChildScrollView _body() => SingleChildScrollView(
        child: Column(
          children: [
            ListItemWithSwitch(
                "Private Account",
                "People will seek permission to follow you",
                widget.isPrivate,
                widget.docId),
            ListItemWithSwitch(
                "Allow Saving",
                "People can save your posts to their profile",
                widget.isPrivate,
                widget.docId),
            listItemWithoutSwitch("Change Password", Icons.chevron_right, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Verify()),
              );
            }),
            listItemWithoutSwitch("Sign Out", Icons.logout_outlined, () {
              signOut(context);
            }),
            listItemWithoutSwitch("Delete Account", Icons.chevron_right, () {
              deleteAccount(context);
            }),
          ],
        ),
      );

  InkWell listItemWithoutSwitch(String text, IconData iconData, onPressFunc) {
    return InkWell(
      onTap: onPressFunc,
      child: Padding(
        padding: Dimen.regularParentPadding,
        child: Row(children: [
          Text(text, style: kHeader4TextStyle),
          const Spacer(),
          Icon(iconData)
        ]),
      ),
    );
  }

  void signOut(BuildContext context) async {
    _auth.signOut();
    prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.WELCOME);
  }

  void deleteAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeleteAccount()),
    );
  }
}

class ListItemWithSwitch extends StatefulWidget {
  final String text;
  final String subText;
  bool? state;
  final String docId;
  ListItemWithSwitch(this.text, this.subText, this.state, this.docId,
      {Key? key})
      : super(key: key);

  @override
  State<ListItemWithSwitch> createState() => _ListItemWithSwitchState();
}

class _ListItemWithSwitchState extends State<ListItemWithSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.text, style: kHeader4TextStyle),
              Text(widget.subText, style: kbody2TextStyle),
            ],
          ),
          FlutterSwitch(
              activeColor: widget.state == true
                  ? Colors.white.withOpacity(1)
                  : Colors.white.withOpacity(0.6),
              toggleColor: AppColors.primary,
              width: 70.0,
              height: 30.0,
              valueFontSize: 25.0,
              toggleSize: 25.0,
              value: widget.state == true,
              borderRadius: 30.0,
              padding: 5.0,
              switchBorder: Border.all(color: AppColors.primary),
              onToggle: (val) async {
                if (widget.text == "Private Account") {
                  Firestore f = Firestore();
                  debugPrint("State is ${widget.state == true}");
                  f.changePrivacy(widget.docId, !(widget.state == true));
                  setState(() {
                    widget.state = !(widget.state == true);
                  });
                }
              })
        ],
      ),
    );
  }
}
