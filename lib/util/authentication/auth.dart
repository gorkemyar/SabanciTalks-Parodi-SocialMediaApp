import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/sign_in/view/verification.dart';
import "package:shared_preferences/shared_preferences.dart";

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late SharedPreferences prefs;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  User? _userFromFirebase(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      prefs = await SharedPreferences.getInstance();

      UserCredential uc =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      prefs.setString("user", (uc.user != null) ? uc.user!.uid : "");

      return uc.user;
      //print(uc.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return e.message ?? "E-mail and/or Password not Found";
        //registerUser();
      } else if (e.code == "wrong-password") {
        return e.message ?? "Wrong Password";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return e.message ?? "Email is already occupied";
      } else if (e.code == "weak-password") {
        return e.message ?? "Weak Password";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("user", "");
    await _auth.signOut();
  }

  // Future<void> resetPass() async {
  //   prefs = await SharedPreferences.getInstance();
  //   dynamic uid = prefs.get("uid");
  //   _auth.sendPasswordResetEmail(email: )
  // }
  Future<void> verify(email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInWithGoogle() async {
    await googleSignIn.signOut();
    prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    debugPrint("out the if");

    UserCredential uc = await _auth.signInWithCredential(credential);
    prefs.setString("user", (uc.user != null) ? uc.user!.uid : "");

    Firestore f = Firestore();

    if (uc.user != null) {
      dynamic id = await f.getUser(uc.user!.uid);

      if (id == null) {
        await f.addUser(uc.user!.uid, uc.user!.displayName);
        await f.createFollowers(uc.user!.uid);
        await f.createFollowing(uc.user!.uid);
        await f.createRequests(uc.user!.uid);
      }
    }
    // need to check this
    return uc.user;
  }
}
