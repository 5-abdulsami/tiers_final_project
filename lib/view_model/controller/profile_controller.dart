import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/res/components/input_text_field.dart';
import 'package:tiers_final_project/utils/utils.dart';
import 'package:tiers_final_project/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  XFile? _image;
  XFile? get image => _image;

  final picker = ImagePicker();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.camera,
                      color: AppColors.primaryIconColor,
                    ),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.photo,
                      color: AppColors.primaryIconColor,
                    ),
                    title: const Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  void uploadImage() async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage${SessionController().userId.toString()}');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      setLoading(false);
      Utils.toastMessage('Profile Picture updated successfully');
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future showUserNameDialogAlert(BuildContext context, String username) {
    nameController.text = username;
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Center(child: Text('Update Username')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: nameController,
                      focusNode: nameFocusNode,
                      onFieldSubmittedValue: (value) {},
                      onValidator: (value) {
                        return value == '' ? 'Enter Username' : null;
                      },
                      obscureText: false,
                      keyboardInputType: TextInputType.name,
                      hint: 'username'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'username': nameController.text.toString(),
                    }).then((value) {
                      nameController.clear();
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Ok',
                      style: Theme.of(context).textTheme.headlineSmall)),
            ],
          );
        }));
  }

  Future showPhoneDialogAlert(BuildContext context, String phone) {
    phoneController.text = phone;
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Center(child: Text('Update Phone Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: phoneController,
                      focusNode: phoneFocusNode,
                      onFieldSubmittedValue: (value) {},
                      onValidator: (value) {
                        return value == '' ? 'Enter Phone Number' : null;
                      },
                      obscureText: false,
                      keyboardInputType: TextInputType.number,
                      hint: 'phone number'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString(),
                    }).then((value) {
                      phoneController.clear();
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Ok',
                      style: Theme.of(context).textTheme.headlineSmall)),
            ],
          );
        }));
  }
}
