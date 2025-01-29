// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

Future toastnotification(
  BuildContext context,
  String actionDisplay,
) async {
  // Add your function code here!
  CherryToast.success(
    disableToastAnimation: false,
    inheritThemeColors: true,
    autoDismiss: true,
    toastPosition: Position.bottom,
    title: Text(
      actionDisplay,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ).show(context);
}
