import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class MyAnalytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static Future<void> setCurrentScreen(name) async {
    await analytics.setCurrentScreen(
      screenName: name,
      screenClassOverride: name,
    );
  }

  static Future<void> setuserId(id) async {
    await analytics.setUserId(
      id: id,
    );
  }

  static Future<void> setLogEvent(email, pass) async {
    await analytics.logEvent(name: "Sign In", parameters: <String, dynamic>{
      'email': email,
      'pass': pass,
    });
  }
}
