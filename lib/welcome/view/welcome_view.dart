import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/sign_in/view/sign_in_view.dart';
import 'package:sabanci_talks/util/styles.dart';
import "package:sabanci_talks/util/dimensions.dart";
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  static const String routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Void',
                  style: voidStyle,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Welcome',
                  style: welcomeStyle,
                ),
              ),
            ),
            const SizedBox(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Welcome to Void, find and contact with your friends. Enjoy Life!',
                  style: smallTextStyle,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              style: TextButton.styleFrom(),
            ),
            const Spacer(),
            Padding(
                padding: Dimen.regularPadding,
                child: Text("@ 2022 Void", style: smallTextStyle))
          ],
        ),
      ),
    );
  }
}
