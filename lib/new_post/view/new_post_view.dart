import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/new_post/view/added_image_view.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sabanci_talks/widgets/show_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final ImagePicker _picker = ImagePicker();

  final List<XFile> imgList = [];
  final _formKey = GlobalKey<FormState>();
  String description = "";
  bool isButtonActive = true;
  Future pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile == null) {
        debugPrint("No photo selected");
      } else {
        imgList.add(pickedFile);
      }
    });
  }

  Future pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile == null) {
        debugPrint("No photo selected");
      } else {
        imgList.add(pickedFile);
      }
    });
  }

  Future uploadPostToFirebase(BuildContext context, List<XFile> images) async {
    // Check the form for errors
    debugPrint("BUTTOON CLICKEEEEEDD");
    setState(() {
      isButtonActive = false;
    });

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      //String fileName = basename(image.path);
      _formKey.currentState!.save();
      Firestore f = Firestore();
      String? uid = await f.decideUser();
      // for every image in the list, upload it to firebase
      List<String> fileNames = [];
      try {
        for (var image in images) {
          String fileName = basename(image.path);
          Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child('uploads/$fileName');

          await firebaseStorageRef.putFile(File(image.path));

          await firebaseStorageRef.getDownloadURL().then((fileURL) {
            debugPrint("File uploaded");
            debugPrint(fileURL);
            fileNames.add(fileURL);
          });
        }
        debugPrint(description);
        debugPrint(fileNames.toString());
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd-kk:mm').format(now);

        await f.addPost(
            uid: uid,
            createdAt: formattedDate,
            urlArr: fileNames,
            postText: description);
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
        //Reference firebaseStorageRef =
        //FirebaseStorage.instance.ref().child('uploads/$fileName');

        //await firebaseStorageRef.putFile(File(image.path));
        //await f.addPost(uid, fileName, description);
        debugPrint("Upload complete");
      } on FirebaseException catch (e) {
        debugPrint('ERROR: ${e.code} - ${e.message}');
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          isButtonActive = true;
        });
      }
    }
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('New Post'),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: isButtonActive
              ? () {
                  debugPrint("Next");
                  uploadPostToFirebase(context, imgList);
                }
              : () {
                  Fluttertoast.showToast(
                      msg: "Please wait until the post is uploaded",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
          child: const Text("Share",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("New Post Page");
    List<Widget> imgViewList = [];
    for (var i = 0; i < imgList.length; i++) {
      imgViewList.add(InkWell(
          onTap: () => setState(() {
                imgList.removeAt(i);
              }),
          child: AddedImageView(imgList[i].path)));
    }

    imgViewList.add(InkWell(
      onTap: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 400),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    SizedBox(
                        width: screenWidth(context),
                        child: TextButton(
                          onPressed: pickImageCamera,
                          child: Padding(
                            padding: Dimen.regularParentPadding,
                            child: Text(
                              "Take a photo",
                              style: kButtonDaTextStyle,
                            ),
                          ),
                        )),
                    SizedBox(
                        width: screenWidth(context),
                        child: TextButton(
                            onPressed: pickImageGallery,
                            child: Padding(
                              padding: Dimen.regularParentPadding,
                              child: Text(
                                "Select image from galery",
                                style: kButtonDaTextStyle,
                              ),
                            ))),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            );
          },
        );
      },
      child: const AddImageView(false),
    ));
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimen.regularParentPadding,
          child: Column(
            children: [
              postForm(context),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: imgViewList)),
            ],
          ),
        ),
      ),
    );
  }

  Widget postForm(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'What is going on?',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              description = value ?? '';
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container()),
        ],
      ),
    );
  }
}
