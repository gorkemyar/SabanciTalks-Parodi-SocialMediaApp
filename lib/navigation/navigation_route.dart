import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/chat/chat_list_view.dart';
import 'package:sabanci_talks/chat/chat_view.dart';
import 'package:sabanci_talks/chat/new_chat_view.dart';
import 'package:sabanci_talks/home/view/comment_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:sabanci_talks/home/view/likes_view.dart';
import 'package:sabanci_talks/navigation/navigation_animation.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/post/view/singe_post_view.dart';
import 'package:sabanci_talks/sign_in/view/forget_password_view.dart';
import 'package:sabanci_talks/sign_in/view/reset_password_view.dart';
import 'package:sabanci_talks/welcome/view/goodby_view.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME:
        return cupertinoNavigate(const HomeView(), NavigationConstants.HOME);

      case NavigationConstants.WELCOME:
        return rightToLeftNavigate(
            const Welcome(), NavigationConstants.WELCOME);
      case NavigationConstants.DELETE:
        return rightToLeftNavigate(
            const DeleteAccount(), NavigationConstants.DELETE);

      case NavigationConstants.BOTTOM_BAR:
        return cupertinoNavigate(
            const BottomBarView(), NavigationConstants.BOTTOM_BAR);
      case NavigationConstants.FORGET_PASS:
        return cupertinoNavigate(
            const ForgetPass(), NavigationConstants.FORGET_PASS);
      case NavigationConstants.RESET_PASS:
        return cupertinoNavigate(
            const ResetPass(), NavigationConstants.RESET_PASS);
      case NavigationConstants.LIKES:
        return cupertinoNavigate(const Likes(), NavigationConstants.LIKES);
      case NavigationConstants.COMMENTS:
        List<String?> temp = args.arguments as List<String?>;
        return cupertinoNavigate(
            Comments(
              postId: temp[0] != null ? temp[0]! : "",
              postOwnerId: temp[1] != null ? temp[1]! : "argerror",
            ),
            NavigationConstants.COMMENTS);
      case NavigationConstants.CHAT:
        return cupertinoNavigate(ChatView(chatId: args.arguments as String),
            NavigationConstants.CHAT);
      case NavigationConstants.CHAT_LIST:
        return cupertinoNavigate(ChatList(), NavigationConstants.CHAT_LIST);
      case NavigationConstants.SINGLE_POST:
        return cupertinoNavigate(
            SinglePostView(post: args.arguments as PostHeroModel),
            NavigationConstants.SINGLE_POST);
      case NavigationConstants.NEW_CHAT:
        return cupertinoNavigate(
            const NewChatView(), NavigationConstants.NEW_CHAT);
      default:
        return defaultNavigate(
            const BottomBarView(), NavigationConstants.DEFAULT);
    }
  }

  MaterialPageRoute defaultNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  CupertinoPageRoute cupertinoNavigate(Widget widget, String pageName) {
    return CupertinoPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  FadeRouteInstant cupertinoNavigateInstant(Widget widget, String pageName) {
    return FadeRouteInstant(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  MaterialPageRoute leftToRightNavigate(Widget widget, String pageName) {
    return LeftToRight(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  MaterialPageRoute rightToLeftNavigate(Widget widget, String pageName) {
    return RightToLeft(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  CupertinoPageRoute bottomToTopNavigate(Widget widget, String pageName) {
    return CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  MaterialPageRoute fadeRouteNavigateInstant(Widget widget, String pageName) {
    return FadeRouteInstant(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  MaterialPageRoute fadeRouteNavigateDelay(Widget widget, String pageName) {
    return FadeRouteWithDelay(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }

  HeroDialogRoute heroDialogNavigateRoute(Widget widget, String pageName) {
    return HeroDialogRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }
}
