import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class FrogotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.toastMessage('Please check your email');
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
