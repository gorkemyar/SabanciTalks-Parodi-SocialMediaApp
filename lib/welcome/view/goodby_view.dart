import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import "package:sabanci_talks/util/dimensions.dart";
import 'package:sabanci_talks/welcome/view/welcome_view.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.white10,
        leading: const BackButton(color: AppColors.primary),
        elevation: 0,
      ),
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
                  'Goodby!',
                  style: welcomeStyle,
                ),
              ),
            ),
            const SizedBox(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: Dimen.regularDoubleParentPadding,
                child: Text(
                  'Account once deleted cannot be restored later. We delete all your data from our servers.',
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
                        pushNewScreenWithRouteSettings(context,
                            screen: const Welcome(),
                            settings: const RouteSettings(),
                            withNavBar: false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Delete My Account',
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
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Hope we will meet again!',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
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
