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

import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

Future<String> newCustomAction3(
    DateTime date,
    String number,
    String from,
    String fromaddress,
    String to,
    String shipto,
    List<dynamic> items,
    String logo,
    String currency,
    String amountpaid) async {
  final apiUrl = 'https://anyapi.io/api/v1/invoice/generate';

  // Prepare the items in the required format
  final itemsJson = items.map((item) {
    return {
      'name': item['name'],
      'unit_cost': item['unit_cost'].toString(),
      'quantity': item['quantity'].toString(),
      'description': item['description'] // If description is needed
    };
  }).toList();

  // Set up the request body
  final requestBody = {
    'date': date.toIso8601String(),
    'number': number,
    'from': from,
    'from_address': fromaddress,
    'to': to,
    'ship_to': shipto,
    'items': itemsJson,
    'logo': logo,
    'currency': currency,
    'amount_paid': amountpaid,
    // Add other necessary parameters
  };

  // Call the API
  final response = await http.post(
    Uri.parse(apiUrl),
    body: requestBody,
    // Add headers if required
  );

  if (response.statusCode == 200) {
    // Store the PDF with a unique name in Firebase Storage
    String fileName = 'invoice_$number.pdf';
    final storageRef = FirebaseStorage.instance.ref().child(fileName);
    final uploadTask = storageRef.putData(response.bodyBytes);

    await uploadTask; // Wait for the upload to complete
    final downloadURL = await storageRef.getDownloadURL();

    return downloadURL;
  } else {
    throw Exception('Failed to call the API');
  }
}
