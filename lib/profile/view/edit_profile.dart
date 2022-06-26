import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'dart:io' show Platform;
import '../../util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:sabanci_talks/util/styles.dart';
import 'package:path/path.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({
    Key? key,
    required this.docId,
    required this.genderPre,
    required this.fullNamePre,
    required this.biographyPre,
    required this.picturePre,
  }) : super(key: key);
  final String docId;
  final String genderPre;
  final String fullNamePre;
  final String biographyPre;
  final String picturePre;
  static const String routeName = '/editProfile';

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';

  String biography = '';

  XFile? myImage;

  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: kWhiteTextStyle,
          ),
          actions: [_saveButton(context)],
        ),
        body: _body(context));
  }

  Padding _body(BuildContext context) => Padding(
      padding: Dimen.regularParentPadding,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _networkImage(
                    newPicture != null ? newPicture : widget.picturePre),
                _sized(),
                _profileImageButton(context),
              ],
            ),
            _divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _editTitles(),
                _sized(),
                Flexible(child: _editInputs()),
              ],
            ),
          ],
        ),
      ));

  Divider _divider() => const Divider(height: 30);

  TextButton _saveButton(BuildContext context) => TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (isButtonActive && myImage != null) {
            await uploadPostToFirebase(context, myImage!);
            debugPrint("Uploaded?");
          }
          Firestore f = Firestore();
          await f.updateUser(widget.docId, fullName, gender, biography,
              newPicture != null ? newPicture : widget.picturePre);
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
        } else {
          debugPrint("Error is from ${fullName}");
          //_showDialog('Form Error', 'Your form is invalid', context);
        }
      },
      child: Text("Save", style: kWhiteTextStyle));

  TextButton _profileImageButton(BuildContext context) => TextButton(
        onPressed: () {
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
        child: const Text("Change Your Profile Photo"),
      );

  SizedBox _sized() {
    return const SizedBox(width: 25);
  }

  Column _editTitles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Username:"),
        _padding(),
        const Text("Gender:"),
        _padding(),
        const Text("Biography:"),
      ],
    );
  }

  Padding _padding() =>
      const Padding(padding: EdgeInsets.symmetric(vertical: 15));

  Column _editInputs() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _editContainer(widget: _name()),
          _divider(),
          _editContainer(widget: _gender()),
          _divider(),
          _editContainer(widget: _bio()),
        ],
      );

  SizedBox _editContainer({required Widget widget}) {
    return SizedBox(
      height: 16,
      width: double.infinity,
      child: widget,
    );
  }

  TextFormField _name() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.nameController,
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        autocorrect: false,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        initialValue: widget.fullNamePre,
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave password empty';
            }
            if (value.length < 3) {
              debugPrint("Error is from length");
              return 'Password too short';
            }
          }
        },
        onSaved: (value) {
          debugPrint("Error is from onsaved");
          fullName = value ?? '';
        },
      );

  TextFormField _gender() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.usernameController,
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        autocorrect: false,
        initialValue: widget.genderPre,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave gender empty';
            }
          }
        },
        onSaved: (value) {
          gender = value ?? '';
        },
      );

  TextFormField _bio() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.bioController,
        textInputAction: TextInputAction.done,
        onChanged: (value) {},
        autocorrect: false,
        initialValue: widget.biographyPre,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave biography empty';
            }
          }
        },
        onSaved: (value) {
          biography = value ?? '';
        },
      );

  Widget _networkImage(profileImage) {
    debugPrint("newpicture is ${newPicture}");

    if (myImage != null) {
      return ClipOval(
          child: Image.file(
        File(myImage!.path),
        width: 64,
        height: 64,
      ));
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        imageBuilder: (context, imageProvider) => Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      );
    }
  }

  Future<void> _showDialog(
      String title, String message, BuildContext context) async {
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

  final ImagePicker _picker = ImagePicker();

  Future pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile == null) {
        debugPrint("No photo selected");
      } else {
        myImage = pickedFile;
      }
    });
  }

  Future pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile == null) {
        debugPrint("No photo selected");
      } else {
        myImage = pickedFile;
      }
    });
  }

  dynamic newPicture;
  bool isButtonActive = true;
  Future uploadPostToFirebase(BuildContext context, XFile image) async {
    // Check the form for errors
    //debugPrint("BUTTOON CLICKEEEEEDD");
    setState(() {
      isButtonActive = false;
    });

    //String fileName = basename(image.path);

    // for every image in the list, upload it to firebase

    try {
      String fileName = basename(image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      await firebaseStorageRef.putFile(File(image.path));
      debugPrint("image  is ${image.path}");
      await firebaseStorageRef.getDownloadURL().then((fileURL) {
        debugPrint("File uploaded");
        debugPrint(fileURL);
        setState(() {
          newPicture = fileURL;
        });
      });
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
