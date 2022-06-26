import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'dart:convert';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'dart:io' show Platform;
import "package:sabanci_talks/util/styles.dart";
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/dimensions.dart";
import "package:sabanci_talks/util/screen_sizes.dart";
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();

  static const String routeName = '/signup';
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  String confirmPass = '';
  String userName = "";
  late String s;
  late SharedPreferences prefs;
  final Authentication _auth = Authentication();
  Future signupUser() async {
    dynamic element = await _auth.registerWithEmailPass(email, pass);
    if (element is String) {
      _showDialog("Sign Up Error", element);
    } else if (element is User) {
      Firestore f = Firestore();
      await f.addUser(element.uid, userName);
      await f.createFollowers(element.uid);
      await f.createFollowing(element.uid);
      await f.createRequests(element.uid);
      prefs = await SharedPreferences.getInstance();
      prefs.setString("user", element.uid);
    } else {
      _showDialog("Sign Up Error", element.toString());
    }
  }

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
          'Create Account',
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: Dimen.moreHorizontal,
                child: Text(
                  'Fill in the required details and click Proceed.',
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
                          label: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 4),
                              Text('Email', style: inputTextStyle),
                            ],
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
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid e-mail address';
                            }
                          }
                        },
                        onSaved: (value) {
                          email = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: screenWidth(context, dividedBy: 1.1),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.portrait_rounded),
                              const SizedBox(width: 4),
                              Text('User Name', style: inputTextStyle),
                            ],
                          ),
                          //fillColor: AppColors.textFieldFillColor,
                          //filled: true,
                          labelStyle: kBoldLabelStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave user name empty';
                            }
                          }
                        },
                        onSaved: (value) {
                          userName = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: screenWidth(context, dividedBy: 1.1),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.password),
                              const SizedBox(width: 4),
                              Text('Password', style: inputTextStyle),
                            ],
                          ),
                          //fillColor: AppColors.textFieldFillColor,
                          //filled: true,
                          labelStyle: kBoldLabelStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave password empty';
                            }
                            if (value.length < 6) {
                              return 'Password too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          pass = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: screenWidth(context, dividedBy: 1.1),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.password),
                              const SizedBox(width: 4),
                              Text('Confirm Password', style: inputTextStyle),
                            ],
                          ),
                          //fillColor: AppColors.textFieldFillColor,
                          //filled: true,
                          labelStyle: kBoldLabelStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave password empty';
                            }
                            if (value.length < 6) {
                              return 'Password too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          confirmPass = value ?? '';
                        },
                      ),
                    ),
                    Padding(
                        padding: Dimen.moreHorizontal,
                        child: Text(
                            "By Creating Account, you are automatically accepting all the Terms & Conditions related to Momento",
                            style: smallTextStyle)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await signupUser();
                            NavigationService.instance.navigateToPageClear(
                                path: NavigationConstants.BOTTOM_BAR);
                          } else {
                            _showDialog('Form Error', 'Your form is invalid');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Create Account',
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          dynamic user = await _auth.signInWithGoogle();
                          if (user != null) {
                            NavigationService.instance.navigateToPageClear(
                                path: NavigationConstants.BOTTOM_BAR);
                          }
                          MyAnalytics.setLogEvent(email, pass);
                          //print('Email: $email');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Sign In With Gmail',
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
      ),
    );
  }
}
