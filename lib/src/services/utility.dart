import 'dart:async';

import 'package:app/src/styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility {
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  static void showSnackBar(_scaffoldKey, msg, context) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("$msg",
          style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.w600)),
      duration: Duration(seconds: 3),
    ));
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static showBottomSheet(body, context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppTheme.kBottomSheetModalUpperRadius),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) => Material(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: body),
      ),
    );
  }
}
