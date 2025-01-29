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
import 'dart:convert';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

Future sendemail(
  String recipientemail,
  String url,
) async {
  // Add your function code here!
  String username = 'sveccha.apps@gmail.com'; // Replace with your SMTP username
  String password = '4VhALB7qcgbYn0wv'; // Replace with your SMTP password
  String smtpServerHost =
      'smtp-relay.brevo.com'; // Replace with your SMTP server host
  int smtpServerPort = 587;

  final smtpServer = SmtpServer(
    smtpServerHost,
    port: smtpServerPort,
    username: username,
    password: password,
    ssl:
        false, // Use SSL for security (set to false if your server doesn't support SSL)
  );

  var response = await http.get(Uri.parse(url));
  var pdfData = response.bodyBytes;
  var tempDir = await getTemporaryDirectory();
  var tempPath = tempDir.path;
  var pdfFile = File('$tempPath/attachment.pdf');
  await pdfFile.writeAsBytes(pdfData);
  final htmlFileUrl =
      'https://firebasestorage.googleapis.com/v0/b/sveccha-11c31.appspot.com/o/Untitled-1%20(1).html?alt=media&token=837db1fa-3dad-4982-baf3-1b091de3e64c';
  final response1 = await http.get(Uri.parse(htmlFileUrl));
  final storage = FirebaseStorage.instance;
  final htmlContent = response1.body;

  // Ensure this method returns the direct URL of the invoice as a String

  final message = Message()
    ..from = Address(username, 'Sveccha') // Replace with your name or app name
    ..recipients.add(recipientemail)
    ..subject = 'Order Placed'
    ..text = url
    ..html = htmlContent
    ..attachments = [FileAttachment(pdfFile)];

  // Make sure FileAttachment is correctly instantiated

  try {
    final sendReport = await send(message, smtpServer);
    print('Email sent: ' + sendReport.toString());
    return 'Email sent successfully';
  } catch (e) {
    print('Error sending email: ' + e.toString());
    return 'Error sending email: ' + e.toString();
  } finally {
    // Optionally delete the PDF file after sending the email
    await pdfFile.delete();
  }
}
