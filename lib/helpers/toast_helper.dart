import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manabie_todolist/theme/ui_color.dart';

// ignore: avoid_classes_with_only_static_members
class ToastHelper {
  static void showToast({String? msg, bool isTrue = true}) {
    Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: isTrue ? UIColor.blue : UIColor.red,
      textColor: Colors.white,
    );
  }
}
