import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/view_model/services/session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteName.dashboardView);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteName.loginView);
      });
    }
  }
}
