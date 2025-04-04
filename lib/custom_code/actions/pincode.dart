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

import 'package:geocoding/geocoding.dart';

Future<String> pincode(LatLng latlng) async {
  // Add your function code here!
  try {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];
      final String address = '${placemark.postalCode}';
      return address;
    } else {
      return 'Address not found';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
