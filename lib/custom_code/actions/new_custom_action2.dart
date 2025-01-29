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

Future<String> newCustomAction2(LatLng latitude) async {
  // Add your function code here!
  try {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude.latitude, latitude.longitude);
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];
      final String address =
          '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea},${placemark.postalCode}, ${placemark.country}';
      return address;
    } else {
      return 'Address not found';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
