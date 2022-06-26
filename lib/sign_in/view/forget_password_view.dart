import 'package:flutter/material.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'dart:io' show Platform;
import "package:sabanci_talks/util/styles.dart";
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/dimensions.dart";
import "package:sabanci_talks/util/screen_sizes.dart";
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();

  static const String routeName = '/signup';
}

class _ForgetPassState extends State<ForgetPass> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  late String s;

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
                  child: const Text('OK'),
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
                  child: const Text('OK'),
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
          'Reset Password',
          style: LittleTitle,
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: AppColors.primary),
      ),
      body: Padding(
          padding: Dimen.regularPadding,
          child: Column(children: [
            const Spacer(flex: 1),
            Padding(
              padding: Dimen.regularParentPadding,
              child: Text(
                'No Problem! Just give in your Email and we will send you a verification code to reset your password.',
                style: smallTextStyle,
              ),
            ),
            const Spacer(flex: 1),
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
                              const Icon(Icons.email),
                              const SizedBox(width: 4),
                              Text('Email', style: inputTextStyle),
                            ],
                          ),
                        ),
                        fillColor: AppColors.textFieldFillColor,
                        filled: false,
                        labelStyle: kBoldLabelStyle,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print('Email: $email');
                        } else {
                          _showDialog('Form Error', 'Your form is invalid');
                        }
                        NavigationService.instance.navigateToPageClear(
                            path: NavigationConstants.RESET_PASS);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Send Verification Code',
                          style: kButtonLittleDarkTextStyle,
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
            const Spacer(flex: 2),
          ])),
    );
  }
}
