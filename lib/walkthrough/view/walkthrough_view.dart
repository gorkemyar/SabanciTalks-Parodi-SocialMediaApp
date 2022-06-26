import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/screen_sizes.dart";

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          bodyWidget: introScreen(
            context,
            1,
            'Welcome to Void',
            'Void is on the way to connect you',
            'https://media.istockphoto.com/vectors/social-network-vector-id505782242',
          ),
          title: "",
        ),
        PageViewModel(
          bodyWidget: introScreen(
            context,
            2,
            'Meet Your Friends',
            'Share your pictures and ideas via Void',
            'https://st.depositphotos.com/1010751/3507/v/950/depositphotos_35075337-stock-illustration-star-friends-logo.jpg',
          ),
          title: "",
        ),
        PageViewModel(
          bodyWidget: introScreen(
            context,
            3,
            'Search and Explore',
            'Find Your People in Void',
            'https://media.istockphoto.com/vectors/people-family-together-human-unity-chat-bubble-vector-icon-vector-id1198036466?k=20&m=1198036466&s=612x612&w=0&h=QSpwvOA8_Gwkr8CYqDIvNGhTBurzIYjAkE-dfzlIOO8=',
          ),
          title: "",
        ),
      ],
      onDone: () => NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.WELCOME),
      onSkip: () => NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.WELCOME),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(color: Colors.black)),
      next: const Icon(Icons.arrow_forward, color: Colors.black),
      done: const Text("Getting Started",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black12,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget introScreen(BuildContext context, int pageId, String pageTitle,
      String bodyText, String imagePath) {
    var size = MediaQuery.of(context).size;
    return (Column(
      children: [
        Container(
            width: size.width,
            height: size.height * 0.1,
            child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                            child: Text("Void",
                                style: TextStyle(color: Colors.white))))
                  ],
                ))),
        SizedBox(
          height: screenHeight(context, dividedBy: 100),
        ),
        Text(
          pageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        //Image.network(imagePath, color: AppColors.primary.withOpacity(1)),
        SizedBox(
          height: screenHeight(context, dividedBy: 14),
        ),
        Container(
            height: screenHeight(context, dividedBy: 3),
            child: Image.network(imagePath)),
        SizedBox(
          height: screenHeight(context, dividedBy: 14),
        ),

        Text(bodyText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 17)),
      ],
    ));
  }
}
