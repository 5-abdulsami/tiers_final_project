import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/utils/utils.dart';
import '../services/session_manager.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void signUp(BuildContext context, String username, String email, String phone,
      String password) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'username': username,
          'email': value.user!.email.toString(),
          'onlineStatus': 'noone',
          'phone': phone,
          'profile': '',
        }).then((value) {
          setLoading(false);
          Navigator.pushNamed(context, RouteName.loginView);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
        setLoading(false);
        Utils.toastMessage('User created Successfully');
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
