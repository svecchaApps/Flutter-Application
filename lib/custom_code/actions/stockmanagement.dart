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

Future stockmanagement(
  DocumentReference orderef,
) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Step 1: Fetch the specific order document using orderef
  DocumentSnapshot orderDocument = await orderef.get();

  if (orderDocument.exists) {
    Map<String, dynamic> orderData =
        orderDocument.data() as Map<String, dynamic>? ?? {};

    // Step 2: Retrieve the 'productrefer' array from the order data
    List<dynamic> productItems =
        orderData['productrefer'] as List<dynamic>? ?? [];

    // Iterate through each item in the array
    for (var productItem in productItems) {
      if (productItem is Map<String, dynamic>) {
        DocumentReference subproductRef = productItem['subproductref'];

        // Check if subproductRef is indeed a DocumentReference
        if (subproductRef is DocumentReference) {
          // Step 3: Fetch the subproduct using the reference
          DocumentSnapshot subproductSnapshot = await subproductRef.get();

          if (subproductSnapshot.exists) {
            Map<String, dynamic> subproductData =
                subproductSnapshot.data() as Map<String, dynamic>? ?? {};
            int currentStock = subproductData['Stock'] as int? ?? 0;

            if (currentStock > 0) {
              // Step 4: Update the stock by decrementing it
              await subproductRef.update({'Stock': currentStock - 1});
            }
            if (currentStock - 1 == 0) {
              await subproductRef.delete();
            }
          }
        } else {
          print("The subproduct reference is not valid");
        }
      }
    }
  } else {
    throw Exception("Order document does not exist.");
  }
}
