import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/new_post/view/added_image_view.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'dart:io';
import 'package:path/path.dart';

class EditPost extends StatefulWidget {
  const EditPost({
    Key? key,
    required this.docId,
    required this.proUrl,
    required this.name,
    required this.oldDescription
  }) : super(key: key);
  final String docId;
  final String proUrl;
  final String name;
  final String oldDescription;

  @override
  State<EditPost> createState() => _EditPostState();

  static const String routeName = '/singlePost';
}

class _EditPostState extends State<EditPost> {
  MyPost? post;
  List<Content> contents = [];
  final _formKey = GlobalKey<FormState>();
  List imgList = [];

  List<Widget> imgViewList = [];

  final ImagePicker _picker = ImagePicker();
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

  @override
  void initState() {
    super.initState();
    getMyPost();
  }

  Future updatePostOnFirebase(BuildContext context, List images) async {
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
          // If the image is the url of the old images don't upload it again
          if (image.runtimeType == String){
            fileNames.add(image);
          }else{
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
          
        }
        debugPrint(description);
        debugPrint(fileNames.toString());

        f.updatePost(
          docId: widget.docId, 
          uid: uid, 
          createdAt: post?.createdAt,
          postText: description, 
          pictureUrlArr: fileNames, 
          likeArr: post != null ?  post!.likeArr: []);
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
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

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    post = await f.getSpecificPost(widget.docId);
    imgList = [];
    for (String url in post!.pictureUrlArr) {
      imgList.add(url);
    }
    setState(() {
      description = post!.postText;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Edit Post Page");
    imgViewList = [];
    description = widget.oldDescription;
    for (var i = 0; i < imgList.length; i++) {
      imgViewList.add(InkWell(
          onTap: () => setState(() {
                imgList.removeAt(i);
              }),
          child: imgList[i].runtimeType == String
              ? AddedImageView(imgList[i], isNetworkImg: true)
              : AddedImageView(imgList[i].path, isNetworkImg: false)));
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
    return FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: const Text("The post is loading...")));
            default:
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
        });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Edit Post'),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: isButtonActive
              ? () {
                  debugPrint("Next");
                  updatePostOnFirebase(context, imgList);
                }
              : () {
                  Fluttertoast.showToast(
                      msg: "Please wait until the post is updated",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
          child: const Text("Update",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        )
      ],
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
            initialValue: widget.oldDescription,
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
