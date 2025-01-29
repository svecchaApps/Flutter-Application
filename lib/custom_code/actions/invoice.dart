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

import 'index.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart';

Future<String> invoice(
  String name,
  String email,
  String phonenumber,
  String city,
  DateTime date,
  String invoiceNumber,
  String grandtotal,
  String hydooz,
  String hydoozemail,
  String hydoozphone,
  List<ProductordersStruct> products,
  DocumentReference? orderref,
  String deliveryfees,
) async {
  // Add your function code here!
  final pdf = pw.Document();

  pw.Widget _buildProductTable() {
    const tableHeaders = [
      'Product Title',
      'Qty',
      'Gross Amount',
      'Discounts/Coupons',
      'Taxable Value ',
      'CGST',
      'SGST',
      'Total '
    ];

    List<List<String>> productList = products.map((product) {
      final grossAmount = product.price.toString();
      final discount = '0.00'; // Example, adjust according to your logic
      final taxableValue = (product.price * product.quantity)
          .toString(); // Simplified calculation
      final cgst = ((product.price * product.quantity) * 0.06)
          .toStringAsFixed(2)
          .toString(); // 9% CGST as an example
      final sgst = ((product.price * product.quantity) * 0.06)
          .toStringAsFixed(2)
          .toString(); // 9% SGST as an example
      final total = ((product.price * product.quantity) +
              (product.price * product.quantity * 0.12))
          .toString(); // Total including taxes

      return [
        product.productname,
        product.quantity.toString(),
        grossAmount,
        discount,
        product.price.toString(),
        cgst,
        sgst,
        total
      ];
    }).toList();

    // Add the shipping and handling charges row
    productList.add([
      'Shipping and Handling Charges',
      '1',
      deliveryfees,
      '-',
      '-',
      '-',
      '-',
      deliveryfees
    ]);

    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(
        width: 1,
      ),
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(),
      headerHeight: 25,
      cellHeight: 40,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
        7: pw.Alignment.centerRight,
      },
      headers: List<String>.generate(
          tableHeaders.length, (index) => tableHeaders[index]),
      data: productList,
    );
  }

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Order Summary',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Indigo Rhapsody by Sveccha',
                style: pw.TextStyle(fontSize: 16)),
            pw.Divider(),
            pw.Text('Order ID: $invoiceNumber'),
            pw.Text('Order Date: $date'),
            pw.Text('Invoice Date: $date'),
            pw.Divider(),
            pw.Text('Bill To:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('$name'),
            pw.Text('$city'),
            pw.Text('Phone: $phonenumber'),
            pw.SizedBox(height: 20),
            _buildProductTable(),
            pw.SizedBox(height: 20),
            pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Grand Total: $grandtotal',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold))),
          ],
        );
      },
    ),
  );

  // Get the directory for storing the PDF
  final dir = await getApplicationDocumentsDirectory();
  final filePath = '${dir.path}/$invoiceNumber.pdf';
  final file = File(filePath);

  // Save the PDF to a file
  await file.writeAsBytes(await pdf.save());

  // Upload the PDF to Firebase Storage
  final ref =
      FirebaseStorage.instance.ref().child('invoices/${orderref!.id}.pdf');
  await ref.putFile(file);

  // Get the download URL of the uploaded PDF
  final url = await ref.getDownloadURL();

  return url;
}
