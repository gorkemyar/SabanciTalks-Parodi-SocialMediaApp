import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/main_bloc/home_bloc.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'package:sabanci_talks/walkthrough/view/walkthrough_view.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:image_picker/image_picker.dart";
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AuthStatus extends StatefulWidget {
  const AuthStatus({Key? key}) : super(key: key);
  @override
  State<AuthStatus> createState() => _AuthStatusState();
}

class _AuthStatusState extends State<AuthStatus> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Welcome();
    } else {
      return const BottomBarView();
    }
  }
}

class MyFirebaseApp extends StatefulWidget {

  const MyFirebaseApp(this._init, {Key? key}) : super(key: key);
  final Future<FirebaseApp> _init;

  @override
  State<MyFirebaseApp> createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  late dynamic uc;
  late int firstLoad;
  late SharedPreferences prefs;

  decideRoute() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      firstLoad = (prefs.getInt('appInitialLoad') ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    decideRoute();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeStarting()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return FutureBuilder(
            future: widget._init,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorScreen(message: snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (firstLoad == 0) {
                  firstLoad = 1;
                  prefs.setInt('appInitialLoad', firstLoad);
                  return const IntroScreen();
                } else {
                  return StreamProvider<User?>.value(
                      value: Authentication().user,
                      initialData: null,
                      child: AuthStatus());
                }
              }
              return const Waiting();
            });
      }),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sabanci Talks Error Screen'),
          centerTitle: true,
        ),
        body: Text(message));
  }
}

class Waiting extends StatelessWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Waiting Screen for Sabanci Talks"),
          centerTitle: true,
        ),
        body: const Center(child: Text("Welcome to Sabanci Talks")));
  }
}
