import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../services/session_manager.dart';

class LoginController with ChangeNotifier {
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

  void login(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Navigator.pushNamed(context, RouteName.dashboardView);
        Utils.toastMessage('Logged in Successfully');
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
