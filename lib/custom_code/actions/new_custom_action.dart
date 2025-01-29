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

import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;

Future<String> newCustomAction(
  String transactionID,
  String merchantId,
) async {
  // Add your function code here!
  String data = "/v3/transaction/$merchantId/$transactionID/status" +
      "6362bd9f-17b6-4eb2-b030-1ebbb78ce518";
  List<int> bytes = utf8.encode(data);
  Digest digest = await sha256.convert(bytes);
  String hash = digest.toString();
  return hash + "###1";
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
