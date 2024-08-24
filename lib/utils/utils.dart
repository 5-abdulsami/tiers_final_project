import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiers_final_project/res/color.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryTextColor,
      textColor: AppColors.whiteColor,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16,
    );
  }
}
