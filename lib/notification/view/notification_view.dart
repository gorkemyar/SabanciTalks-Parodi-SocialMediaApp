import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/notification/view/notification_widget_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  dynamic notificationList;
  dynamic uid;
  Future<void> getNotifications() async {
    Firestore f = Firestore();
    uid = await f.decideUser();
    notificationList = await f.getNotification(uid);
  }

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) => NotificationWidget(
                    notification: notificationList[index],
                    refreshFunction: () {
                      debugPrint("helloooo from deneme");
                      setState(() {});
                    },
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
              itemCount:
                  notificationList != null ? notificationList.length : 0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Notification Page");
    return FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notifications"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseCrashlytics.instance.crash();
                  },
                  child: const Text(
                    "Throw Test Exception",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: SafeArea(
                child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) => NotificationWidget(
                          notification: notificationList[index],
                          refreshFunction: () {
                            debugPrint("helloooo from deneme");
                            setState(() {});
                          },
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                    itemCount:
                        notificationList != null ? notificationList.length : 0),
              ),
            )),
          );
        });
  }
}
