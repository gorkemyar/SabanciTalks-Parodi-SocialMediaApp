import 'package:flutter/material.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/sign_in/view/reset_password_view.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'dart:io' show Platform;
import "package:sabanci_talks/util/styles.dart";
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/dimensions.dart";
import "package:sabanci_talks/util/screen_sizes.dart";
import 'package:flutter/cupertino.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();

  static const String routeName = '/signup';
}

class _VerifyState extends State<Verify> {
  final _formKey = GlobalKey<FormState>();
  String code = '';

  late String s;
  final Authentication _auth = Authentication();
  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: kBoldLabelStyle),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, style: kLabelStyle),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Password',
            style: LittleTitle,
          ),
          backgroundColor: Colors.white10,
          elevation: 0,
          centerTitle: true,
          leading: const BackButton(color: AppColors.primary),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: Dimen.regularPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: Dimen.moreHorizontal,
                      child: Text(
                        'Fill in the required details and click Reset Password.',
                        style: smallTextStyle,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            width: screenWidth(context, dividedBy: 1.1),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                label: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.email),
                                      SizedBox(width: 4),
                                      Text('Email', style: inputTextStyle),
                                    ],
                                  ),
                                ),
                                fillColor: AppColors.textFieldFillColor,
                                filled: false,
                                labelStyle: kBoldLabelStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Cannot leave e-mail empty';
                                  }
                                }
                              },
                              onSaved: (value) {
                                code = value ?? '';
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _auth.verify(code);
                                  NavigationService.instance
                                      .navigateToPageClear(
                                          path: NavigationConstants.BOTTOM_BAR);
                                } else {
                                  _showDialog(
                                      'Form Error', 'Your form is invalid');
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Reset Password',
                                  style: kButtonDarkTextStyle,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
        ));
  }
}
